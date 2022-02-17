# taste-crossplane

With this repository, you will be able to have a taste of crossplane and you can actually get your hands dirty as well.

## Docs

- [Why Crossplane](./docs/why-crossplane.md)
- [Why Not Terraform](./docs/why-not-terraform.md)
- [other docs](./docs)

## Take Off

### Prerequisites

- [fork the this repository](../../fork)
- dependencies are currently defined at [./shell.nix](./shell.nix)
- [run this](../../actions/workflows/fix-username.yml) or `make fix-username` to point your forked repo for `fluxcd` not the original repo
- and [export your credentials](https://fluxcd.io/docs/get-started/#export-your-credentials)

### Run

`make provision`

### Apply Your Own Changes
- **make sure** you forked the repository instead of cloning the original repository
- **make sure** you fixed the username via [this workflow](../../actions/workflows/fix-username.yml), so source url for fluxcd is fixed via the newest commit
- commit and push to `main` branch
	- run [this workflow](../../actions/workflows/add-sa.yml) to be quickly go through this
-	verify fluxcd detects and applys the new changes
	- fluxcd detects -> new Crossplane CRD is created
	- [Crossplane tries reconcile the changes](../docs/why-crossplane.md#deploy-sequence-with-crossplane--other-enhancements)
	- `make status` will show you something like this below

```bash
minikube status -p taste-crossplane
taste-crossplane
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

kubectl get kustomizations.kustomize.toolkit.fluxcd.io -n flux-system
NAME                       READY   STATUS                                                            AGE
aws                        True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
crossplane                 True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
flux-system                True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
mock-cloud                 True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
provide                    True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
provider-aws-with-config   True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
provider-base              True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
provider-base-aws          True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h
provider-with-config       True    Applied revision: main/352be952fe8ecbc02aa3a5157ab1ec5b169dbaee   18h

kubectl get object.kubernetes.crossplane.io
NAME                    SYNCED   READY   AGE
mock-cloud-crossplane   True     True    18h
this-new-sa             True     True    11m

kubectl get sa -n mock-cloud
NAME          SECRETS   AGE
default       1         18h
this-new-sa   1         11m
```

## Clean Up
`make delete`

### Code Style

- I try to minimize imperative ways of coding when it comes to both producing the code and using the produced code
- for example, running multiple commands to install this and that
- I'm a big beliver on declarative programming and a big fan of relying on automated procedures
- that's also why there is a heavy usage on `kustomize` and `fluxcd` and even (optionally) `nix`
- I want tools to do the job for me because they are better at it
