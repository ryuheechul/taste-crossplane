#!/usr/bin/env bash

set -e

# this makes it easy to call other scripts using relative path
script_d="$(dirname "$0")"

"${script_d}/verify/crossplane.sh"
"${script_d}/verify/aws.sh"
