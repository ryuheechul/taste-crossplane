#!/usr/bin/env bash

yq -i "
(
	select(.kind == \"GitRepository\")
	| select(.spec.url == \"https*\")
	| .spec.url
) = \"https://github.com/${GITHUB_USER}/taste-crossplane\"
" "$1"

yq -i "
(
	select(.kind == \"GitRepository\")
	| select(.spec.url == \"ssh*\")
	| .spec.url
) = \"ssh://git@github.com/${GITHUB_USER}/taste-crossplane\"
" "$1"
