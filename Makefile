kustomize-build =	kubectl kustomize --enable-helm ./kustomize/crossplane

.PHONY: status
status:
	minikube status -p taste-crossplane

.PHONY: cluster
cluster:
	minikube start -p taste-crossplane

.PHONY: build
build:
	$(kustomize-build)

.PHONY: crossplane
crossplane:
	$(kustomize-build) | kubectl apply -f -
