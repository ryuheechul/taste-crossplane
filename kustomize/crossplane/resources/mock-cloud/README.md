# Mock cloud

Now Crossplane is on action to actually making changes on our target provider.

Even though it's not a cloud provider we are targeting in this example (since it's targeting to a same Kubernetes cluster), but there is no difference how it's done even if this was a AWS or GCP.

You just need [a provider setup](../provider-kubernetes) so you can talk to the provider (i.e. AWS, GCP, etc).

Create a CRD manifest (i.e. [./namespace.yaml](./namespace.yaml))


## Verifications

- `kubectl get object` to check Synced status.
- `kubectl describe object` to view the details for possible failure reasons.
- `kubectl describe ns mock-cloud` to see the resource created by Crossplane
