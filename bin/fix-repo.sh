#!/usr/bin/env bash

yq -i ".spec.url = \"https://github.com/${GITHUB_USER}/taste-crossplane\"" "$1"
