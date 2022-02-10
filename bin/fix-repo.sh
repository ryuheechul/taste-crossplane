#!/usr/bin/env bash

cat <<< "---
$(cat $1 | yq ".spec.url = \"https://github.com/${GITHUB_USER}/taste-crossplane\"" -y)
"
