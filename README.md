# taste-crossplane

With this repository, you will be able to have a taste of crossplane and you can actually get your hands dirty as well.

## Docs

- [Why Crossplane](./docs/why-crossplane.md)
- [Why Not Terraform](./docs/why-not-terraform.md)
- [other docs](./docs)

## Take Off

### Prerequisites

- [fork the this repository](./fork)
- dependencies are currently defined at [./shell.nix](./shell.nix)
- `make fix-username` to point your forked repo for `fluxcd` not the original repo
- and [export your credentials](https://fluxcd.io/docs/get-started/#export-your-credentials)

### Run

`make provision`

### Apply Your Own Changes
- **make sure** you forked the repository instead of cloning the original repository
- commit and push to `flux` branch
-	verify fluxcd detects and applys the new changes

## Clean Up
`make delete`

### Code Style

- I try to minimize imperative ways of coding when it comes to both producing the code and using the produced code
- for example, running multiple commands to install this and that
- I'm a big beliver on declarative programming and a big fan of relying on automated procedures
- that's also why there is a heavy usage on `kustomize` and `fluxcd` and even (optionally) `nix`
- I want tools to do the job for me because they are better at it
