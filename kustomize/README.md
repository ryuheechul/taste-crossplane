# kustomize

Crossplane sits on top of a Kubernetes cluster.
That means we will need to deploy things kubernetes in order to this Crossplane thing to work properly.

### There are many way to deploy things to Kubernetes including:
1. directly via `kubectl apply`
2. `helm`
3. `kustomize` directly
4. `kustomize` + `fluxcd`
5. etc. like `skaffold`, `garden.io`

### In this example I choose 4. `kustomize` + `fluxcd` for these reasons:
- `kustomize` gives you really good understanding about the final deployed results
- `helm` may be help to incapsulate the details but often templates can be quite complex thus discouraging clear analysis
- but fear not `kustomize` can make use of helm charts via `helmChartInflationGenerator`
- `fluxcd` fulfills GitOps workflow for kustomize for automations to take responsible to deliver the changes without manual human operation

An example of using `helmChartInflationGenerator`: [./crossplane/system/with-inflator/kustomization.yaml](./crossplane/system/with-inflator/kustomization.yaml)

## Structure

- [crossplane](./crossplane): Crossplane manifests
- [shim](./shim): shim(s) that smooth the experience of a tasting crossplane
- [.templates](./.templates): code to help generating from templates
