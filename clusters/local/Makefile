flux-source-file = ./taste-crossplane-source.yaml
temp-file-fix-repo-taste-crossplane = /tmp/fix-typo

.PHONY: fix-repo
fix-repo:
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	@../../bin/fix-repo.sh $(flux-source-file)
	git diff $(flux-source-file)

.PHONY: revert-repo
revert-repo:
	@git checkout -- $(flux-source-file)
	git diff $(flux-source-file)
