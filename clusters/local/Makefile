flux-system-source-file = ./flux-system/gotk-sync.yaml
flux-source-file = ./taste-crossplane-source.yaml

.PHONY: fix-username
fix-username:
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	@../../bin/fix-username.sh $(flux-system-source-file)
	@../../bin/fix-username.sh $(flux-source-file)
	git diff $(flux-source-file) $(flux-system-source-file)
	@echo ""; echo 'Do `git commit` if these changes are intended.'; echo ""
	@echo 'you can also `make revert-username`'; echo ""

.PHONY: revert-username
revert-username:
	@git checkout -- $(flux-source-file) $(flux-system-source-file)
	git diff $(flux-source-file) $(flux-system-source-file)
