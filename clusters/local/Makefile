flux-system-source-file = ./flux-system/gotk-sync.yaml
flux-self-source-file = ./self/source.yaml

.PHONY: fix-username
fix-username:
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	@../../bin/fix-username.sh $(flux-system-source-file)
	@../../bin/fix-username.sh $(flux-self-source-file)
	git diff $(flux-self-source-file) $(flux-system-source-file)
	@echo ""; echo 'Do `git commit` if these changes are intended.'; echo ""
	@echo 'you can also `make revert-username`'; echo ""

.PHONY: revert-username
revert-username:
	@git checkout -- $(flux-self-source-file) $(flux-system-source-file)
	git diff $(flux-self-source-file) $(flux-system-source-file)
