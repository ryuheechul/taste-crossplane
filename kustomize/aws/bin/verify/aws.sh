#!/usr/bin/env bash

echo "verifying in aws side..."

user_fetched="$(aws iam get-user --user-name=test-user-created-by-crossplane)"

result="$(echo "${user_fetched}" | jq -r '
.User.Tags[0]
| select(.Key == "provided-by")
| select(.Value == "provider-aws")
| .Value
')"

! test "provider-aws" == "${result}" && echo "not sure if the user exist" && exit 1

echo "found in aws"
