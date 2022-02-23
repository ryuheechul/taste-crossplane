# provider-aws

We used [provider-kubernetes](../provider-kubernetes) to be able to see the provider working even without access to cloud providers like AWS.

However, actually nothing stops us from deploying AWS manifests via Crossplane, it will just simply not reconcile because it lacks access to cloud.
But we still can see how it looks like to deploy AWS resources via Crossplane by this example.

## Setup access to AWS

In case you do have access to AWS and you actually want to try it out, that can be done by `bin/apply-secret.sh`
## What exactly happens?

1. Install the "provider"
By adding [./base/provider.yaml](./base/provider.yaml) to Crossplane cluster.

2. Establish connection
By adding [./with-config/providerconfig.yaml](./with-config/providerconfig.yaml)
Which await for a Secret below

```
# can be created by `bin/apply-secret.sh`
apiVersion: v1
data:
  creds: xXx=
kind: Secret
metadata:
  name: aws-creds
  namespace: crossplane-system
type: Opaque
```

3. Ready to make changes
Crossplane will now watch for any resources that are derived from `*.aws.crossplane.io` and reconcile.
