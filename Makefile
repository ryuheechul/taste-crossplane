flux-bootstrap = flux bootstrap github \
	--owner=$(GITHUB_USER) \
	--repository=taste-crossplane \
	--branch=main \
	--path=./clusters/local \
	--personal

.PHONY: status
status:
	minikube status -p taste-crossplane
	kubectl get kustomizations.kustomize.toolkit.fluxcd.io -n flux-system
	@echo
	kubectl get object.kubernetes.crossplane.io
	@echo
	kubectl get sa -n mock-cloud
	@echo
	kubectl get users.iam.aws.crossplane.io

.PHONY: cluster
cluster:
	minikube start -p taste-crossplane

.PHONY: stop
stop:
	minikube stop -p taste-crossplane

.PHONY: delete
delete: stop
	minikube delete -p taste-crossplane

.PHONY: inflate
inflate:
	cd kustomize && $(MAKE) -s inflate

##### MANUAL KUSTOMIZE DEPLOYMENT - useful if you are not using fluxcd

.PHONY: deploy-all
deploy-all: cluster
	cd kustomize && $(MAKE) -s deploy-all

##### end of MANUAL KUSTOMIZE DEPLOYMENT

##### or you can just let fluxcd to drive it for you
.PHONY: setup-fluxcd
setup-fluxcd: cluster
	@test -n "$(GITHUB_TOKEN)" || (echo '$$GITHUB_TOKEN is not found' && false)
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	$(flux-bootstrap) || (echo "trying again..." && sleep 10 && $(flux-bootstrap))

.PHONY: provision
provision: setup-fluxcd

.PHONY: fix-username
fix-username:
	@cd clusters/local && $(MAKE) fix-username

.PHONY: revert-repo
revert-username:
	@cd clusters/local && $(MAKE) revert-username

.PHONY: act-add-sa
act-add-sa:
	yq .act/events/add-sa-default.yaml -o json | act --env USER=bot -j add-sa -e /dev/stdin
