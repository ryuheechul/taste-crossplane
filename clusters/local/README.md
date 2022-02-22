This is where we define FluxCD for a specific cluster

### But How?

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: flux-system
  namespace: flux-system
spec:
  interval: 10m0s
  path: ./clusters/local
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
```
from [gotk-sync.yaml](./flux-system/gotk-sync.yaml) says so.

### The Gists

- [this repo itself is defined as a Source.](./taste-crossplane-source.yaml) 
- [and what to be deployed is defined at ./taste-crossplane-kustomization.yaml](./taste-crossplane-kustomization.yaml) 
- [https://github.com/ryuheechul/taste-crossplane-external-repo-example is also defined as another Source](./external-repo-source.yaml)
- [and what to be deployed is defined for above is at ./external-repo-kustomization.yaml](./external-repo-kustomization.yaml)


### More to Read
https://fluxcd.io/docs/components/source/
