#!/usr/bin/env bash

AWS_PROFILE=${AWS_PROFILE:-default}

# this makes it easy to call other scripts using relative path
script_d="$(dirname "$0")"

cred_file="${script_d}/creds.conf"

echo -e "[default]
aws_access_key_id = $(aws configure get aws_access_key_id --profile $AWS_PROFILE)
aws_secret_access_key = $(aws configure get aws_secret_access_key --profile $AWS_PROFILE)" > "${cred_file}"
