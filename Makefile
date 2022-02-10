flux-bootstrap = flux bootstrap github \
	--owner=$(GITHUB_USER) \
	--repository=taste-crossplane \
	--branch=flux \
	--path=./clusters/local \
	--personal

.PHONY: status
status:
	minikube status -p taste-crossplane

.PHONY: cluster
cluster:
	minikube start -p taste-crossplane

.PHONY: stop
stop:
	minikube stop -p taste-crossplane
	minikube delete -p taste-crossplane

.PHONY: inflate
inflate:
	cd kustomize && $(MAKE) inflate

##### MANUAL KUSTOMIZE DEPLOYMENT - useful if you are not using fluxcd

.PHONY: deploy-all
deploy-all: cluster
	cd kustomize && $(MAKE) deploy-all

##### end of MANUAL KUSTOMIZE DEPLOYMENT

##### or you can just let fluxcd to drive it for you
.PHONY: setup-fluxcd
setup-fluxcd: cluster
	@test -n "$(GITHUB_TOKEN)" || (echo '$$GITHUB_TOKEN is not found' && false)
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	$(flux-bootstrap) || (echo "trying again..." && sleep 10 && $(flux-bootstrap))
