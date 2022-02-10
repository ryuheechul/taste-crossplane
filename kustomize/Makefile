kustomize-build = kubectl kustomize --enable-helm
kustomize-build-crossplane = $(kustomize-build) ./crossplane/with-inflator

.PHONY: inflate
inflate:
	$(kustomize-build-crossplane) > ./crossplane/hard-coded/chart-rendered.yaml

##### MANUAL KUSTOMIZE DEPLOYMENT - useful if you are not using fluxcd

.PHONY: crossplane
crossplane:
	$(kustomize-build-crossplane) | kubectl apply -f -
	kubectl wait --for=condition=Available deployment crossplane --namespace=crossplane-system --timeout=60s

.PHONY: provide
provide:
	$(kustomize-build) ./provide | kubectl apply -f -
	kubectl wait --for=delete secret/kubeconfig --timeout=20s

.PHONY: provider-core
provider-core: crossplane
	$(kustomize-build) ./provider-kubernetes/core | kubectl apply -f -
	kubectl wait --for=condition=Healthy providers provider-kubernetes --timeout=30s

.PHONY: provider
provider: provider-core provide
	$(kustomize-build) ./provider-kubernetes/with-config | kubectl apply -f -
	kubectl wait --for=condition=Healthy providers provider-kubernetes --timeout=30s

.PHONY: mock-cloud
mock-cloud: provider
	$(kustomize-build) ./mock-cloud | kubectl apply -f -
	kubectl wait --for=condition=Ready object mock-cloud-crossplane --timeout=120s

##### end of MANUAL KUSTOMIZE DEPLOYMENT

.PHONY: deploy-all
deploy-all: mock-cloud
