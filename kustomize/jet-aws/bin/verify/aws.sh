#!/usr/bin/env bash

echo "verifying in aws side..."

user_fetched="$(aws iam get-user --user-name=test-user-created-by-crossplane-jet)"

result="$(echo "${user_fetched}" | jq -r '
.User.Tags[0]
| select(.Key == "provided-by")
| select(.Value == "provider-jet-aws")
| .Value
')"

! test "provider-jet-aws" == "${result}" && echo "not sure if the user exist" && exit 1

echo "found in aws"
