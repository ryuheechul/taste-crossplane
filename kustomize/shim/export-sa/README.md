# export-sa

Your main use case of any cloud provisioning tool like Crossplane is for AWS, GCP, Azur, etc.

Then why are we trying to manipulate a Kubernetes cluster instead of one of those cloud providers?

- I want this example to be runnable by everyone and not everyone would have access to a cloud provider
- even if you do have access to a cloud, spinning up actual resource and paying for them is an overkill for the purpose of this project

What happens in this deployment is equivalent of (in case of AWS):

- issuing a new IAM account that has access to AWS
- assign appropriate permissions to it
- accquiring credentials so that it can be used by Crossplane cluster

Also to avoid running a separate Kubernetes cluster for a target (for a resource consumption concern, we just use Crossplane cluster itself as a target provider) in this example.
