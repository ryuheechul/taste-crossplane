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
	$(kustomize-build-crossplane) | kubectl apply -f - && sleep 3

.PHONY: provide
provide:
	$(kustomize-build) ./kustomize/provide | kubectl apply -f -

.PHONY: provider
provider: crossplane provide
	$(kustomize-build) ./kustomize/provider-kubernetes | kubectl apply -f -

.PHONY: mock-cloud
mock-cloud: provider
	$(kustomize-build) ./kustomize/mock-cloud | kubectl apply -f -
