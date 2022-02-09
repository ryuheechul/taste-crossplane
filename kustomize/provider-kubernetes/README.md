# provider-kubernetes 

This is what we setup that enables Crossplane to establish connection to a target provider.

This particular example is connecting to Kubernetes via https://github.com/crossplane-contrib/provider-kubernetes following https://github.com/crossplane-contrib/provider-kubernetes#install.

If this was for [AWS](https://github.com/crossplane/provider-aws), you might do [this](https://github.com/crossplane/provider-aws/blob/master/INSTALL.md#install) instead.

And this is one of the powerful features of Crossplane.

No matter what providers are you just configure them like this and then you are ready to make changes for the provider.

## What exactly happens?

1. Install the "provider"
By adding [./core/provider.yaml](./core/provider.yaml) to Crossplane cluster.

2. Establish connection
By adding [./with-config/providerconfig.yaml](./with-config/providerconfig.yaml) to Crossplane cluster.

3. Ready to make changes
Crossplane will now watch for any resources that are derived from `*.kubernetes.crossplane.io` and reconcile.
