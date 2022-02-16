# Why Crossplane (WIP)

read [./why-not-terraform.md](./why-not-terraform.md) for more context

- adapts Kubernetes ways to Infrastructure management
- individual reconciliation for each infrastructure resource
- fits well with cloud-agnostic approach
- can act as multi cloud control tower

## Diagrams

### User Journey - Deploy via Crossplane + Gitops
```mermaid
journey
  title Deploy via Crossplane
  section Human
    Quick PR via template: 6: Github Actions
    Push changes to a repo: 4: User
  section Automated
    GitOps deploys: 7: FluxCD, Kustomize
    Crossplane reconciles: 7: Crossplane
    Resource gets created: 7: Crossplane
    Output is updated and consumable: 7: Kubernetes
```

### Deploy Sequence With Crossplane + Other Enhancements

```mermaid
sequenceDiagram
    actor u as User
    participant g as Git Repo
    participant f as FluxCD
    participant k as Kubernetes
    participant c as Crossplane
    participant p as Provider Plugin
    participant ap as Actual Provider

    Note right of p: think Terraform Provider
    Note left of u: User: aka Engineer
    Note left of f: FluxCD watches and pulls
    Note right of f: via Kustomize
    Note right of k: via CRDs
    u-)+g: Push changes
    g-->>+f: Sync the repo
    deactivate g
    f-->>+k: build and deploy
    deactivate f
    k-->>+c: detect changes
    deactivate k
    c-->>+p: delegates
    deactivate c
    Note left of ap: i. e. AWS, GCP
    p-->>+ap: reconcile via API
    deactivate p
    ap-->>+k: update status and output
    deactivate ap
    k-->>u: output is available to be consumed
    deactivate k
```

## Other articles
- https://next.redhat.com/2020/10/29/production-ready-deployments-using-the-crossplane-operator-to-manage-and-provision-cloud-native-services/

## Footnote
read [gotchas.md](./gotchas.md)
