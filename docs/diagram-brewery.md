# new diagrams are brewing here

### Deploy sequence with Crossplane

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


### User journey - Deploy via Crossplane + GitOps
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
    Output is updated and usable: 7: Kubernetes
```

### User journey - Deploy via Terraform + Atlantis
```mermaid
journey
  title Deploy via Terraform
  section User
    learn how to code terraform: 3: User
    find the "right" root module: 1: User
    fit the change into "right" places: 2: User
    Push changes to a repo: 4: User
  section Partially Automated
    CI checks and plans: 6: User, Atlantis
    deploy via PR comment: 4: User, Atlantis
    Resource gets created: 7: Terraform
    Output is viewable: 3: Terraform
```

### User journey - Deploy via Terraform manually
```mermaid
journey
  title Deploy via Terraform manually
  section Terraform master
    learn how to code terraform: 3: User
    find the "right" root module: 1: User
    fit the change into "right" places: 2: User
    Ask admin to deploy: 2: User, Admin
    or master deploy and do it yourself: 1: User
    🙏 for repo is synced right away: 2: User
    🙏 for no snowflake local env: 1: User
    🙏 for no untracked vars somewhere: 1: User
```
