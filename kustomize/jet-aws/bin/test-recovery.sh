#!/usr/bin/env bash

set -e

echo "verifying first"; echo ""

# this makes it easy to call other scripts using relative path
script_d="$(dirname "$0")"

"${script_d}/verify.sh"

echo "now we are going to delete the user..."

aws iam delete-user --user-name=test-user-created-by-crossplane-jet

echo "deleted the user"

echo "sleep 10 seconds and verify again to detect deletion..."

sleep 10
"${script_d}/verify.sh" &> /dev/null && echo "it shouldn't succeed already" && exit 1

echo "it looks like crossplane detected deletion"

echo "sleep 20 seconds and verify again to detect recreation..."

sleep 20

"${script_d}/verify.sh"

echo "automatic recovery was successfully tested"
