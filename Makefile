kustomize-build = kubectl kustomize --enable-helm
kustomize-build-crossplane = $(kustomize-build) ./kustomize/crossplane

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

.PHONY: build
build:
	$(kustomize-build-crossplane)

.PHONY: crossplane
crossplane: cluster
	$(kustomize-build-crossplane) | kubectl apply -f -
	kubectl wait --for=condition=Available deployment crossplane --namespace=crossplane-system --timeout=60s

.PHONY: provide
provide:
	$(kustomize-build) ./kustomize/provide | kubectl apply -f -
	kubectl wait --for=delete secret/kubeconfig --timeout=20s

.PHONY: provider-core
provider-core: crossplane
	$(kustomize-build) ./kustomize/provider-kubernetes/core | kubectl apply -f -
	kubectl wait --for=condition=Healthy providers provider-kubernetes --timeout=30s

.PHONY: provider
provider: provider-core provide
	$(kustomize-build) ./kustomize/provider-kubernetes/with-config | kubectl apply -f -
	kubectl wait --for=condition=Healthy providers provider-kubernetes --timeout=30s

.PHONY: mock-cloud
mock-cloud: provider
	$(kustomize-build) ./kustomize/mock-cloud | kubectl apply -f -
	kubectl wait --for=condition=Ready object mock-cloud-crossplane --timeout=120s

.PHONY: setup-fluxcd
setup-fluxcd:
	@test -n "$(GITHUB_TOKEN)" || (echo '$$GITHUB_TOKEN is not found' && false)
	@test -n "$(GITHUB_USER)" || (echo '$$GITHUB_USER is not found' && false)
	flux bootstrap github \
		--owner=$(GITHUB_USER) \
		--repository=taste-crossplane \
		--branch=flux \
		--path=./clusters/local \
		--personal
