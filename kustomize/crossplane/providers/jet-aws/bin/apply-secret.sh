#!/usr/bin/env bash

# this makes it easy to call other scripts using relative path
script_d="$(dirname "$0")"

cred_file="${script_d}/creds.conf"
sink_script="${script_d}/sink-creds.sh"

! test -f "${cred_file}" &&  echo "${cred_file} not found. running ${sink_script}"; ${sink_script}

kubectl create secret generic aws-creds -n crossplane-system --from-file=creds="${cred_file}"

# comment this line if you want to debug
rm "${cred_file}"
