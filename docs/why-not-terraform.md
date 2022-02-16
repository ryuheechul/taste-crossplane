# Why not Terraform?

Terraform changed how we manage infrastructure in a good way.
It convinced us that declarative management of infrastructure can become much simpler than imperative approach counterparts.

You want a resource, you declare it and terraform does the dirty work of talking to the systems (most of the time, cloud providers) and now you have it.
It liberates us from having to directly deal with each vendor's specific way of communication.

It's a great tool and I really liked the experience of using Terraform but I'm not done here and neither the industry.

## Do we need more?

While I'm not arguing that we should not use Terraform all together, in many cases it can be replaced by something like Crossplane for reasons that I will talk about shortly.

### Shortcomings of Terraform experience
> also read https://blog.crossplane.io/crossplane-vs-terraform/

#### state management

You will need to decide where to store the state. Local? S3?
It can be tricky to handle the corruption, when state deviates from actual state in your cloud provider.

Since we can't just simply trust the stored terraform state, 
most likely `terraform plan` will "refresh" the state 
which can take 10 of minutes (if not more) depending on how many resources are maanged by your root module.

That becomes more and more problem as usually root modules only grow bigger over time, thus slower.
That means even though actual adding another resource operation takes constant time, doing it via Terraform takes linearly longer over time.
Do we want to wait 30 minutes just be able to add an IAM user (every time)? I've been there.

#### how many root modules and how big it should be?

Do we manage just one root module for the whole infrastructure or is it too big so it should be split into multiple? 
Once that decision is made not only it's hard to revert later on, but each root module requires proper configuration like state management and deployment pipeline etc.

#### having to apply "manually"

Although there are options like Atlantis (CI/CD for Terraform - which is much better than a case that only selected few manaully run on local machines), 
we still tend to `/terraform apply` manually in a PR after reviewing the result of `terraform plan` as a comment in the PR.

#### PR queue chaos

Imagine five different PRs waiting to be merged (it was quite common for me in a previous workplace).

`#1` is planned and the Terraform state is locked now all other PRs are not appliable until this gets merged and unlocked the state.
After `#1` is merged, now `#2` (or any other really) is out-dated, so now the plan might include deletion of what's added from `#1` if `#2` doesn't pull the changes from upstream.
PR filers usually don't know what to in that situation so it requires minor time sensitive coordinations every time.

And not just that, this dependency handling situations can get much more complicated than above easily.
Without having "experts" handling these in time, PRs will have to wait longer than necessary and make a bad impression of "applying infrastructure changes are slow and painful",
which creates more fear and less involvements from engineers.
Is that what we want? We probably want the opposite which is self-servable IaC.

### How about Kubernetes Operator pattern approach?

One of the important aspects of how Kubernetes working to me is about its continous reconciliation.
You create a manifest, and Kubernetes try to reconcile that to a realilty and let you know the result via Events and status.

This pattern has been loved so much that now it's been [possible to make your own operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)

A thing to note about this is that every manifest is independently being reconciled.

Imagine Terraform's resource stanza is independently being reconciled, so tiny change can be applied quickly because it only checks the status the target and its dependencies.

That's pretty much the essential of what Crossplane does, it bring Kubernetes reconciliation to a declarative infrastructure management.

Crossplane is an operator that specializes on talking to providers via API and continuously reconcile.
ĸ
That's why it runs on top of Kubernetes.

## Benefits of Crossplane

- free from managing states, just let crossplane manages that (the Kubernetes cluster becomes the living database)
- (fast) individual reconciliation
- leverage Kubernetes echo system like Kustomize, FluxCD (GitOps) and many more
- readable infrastructure resouce representation as a code (especially with the synergy with Kustomize, what you see can be what you have)
- manage infrastructure as if resources are simply Kubernetes objects via provider specific CRDs
- lots of automation points (like script or Github Actions to create new resources, linting and tests)
- more on this, look [here](./why-crossplane.md)


## What might be missing from not using Terraform (directly)

- Terraform is more mature than Crossplane by years
- documentation friendliness
- imperative style of operation with `terraform plan/apply`
- a peace of mind from using proven technology since Crossplane is younger and less exposed to us
