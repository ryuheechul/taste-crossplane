#!/usr/bin/env bash

echo "verifying in Kubernetes side..."

conditions="$(kubectl get users.iam.aws.jet.crossplane.io test-user-created-by-crossplane-jet \
	-o jsonpath='{.status.conditions}')"

result="$(echo "${conditions}" | jq -r '.[] | select(.reason == "ReconcileSuccess") | .status')"

err_msg="it is not reconciled, maybe you want to read ../provider-aws/README.md"
! test "True" == "${result}" && echo "${err_msg}" && exit 1

echo "appeared to be reconciled status"
