# taste-crossplane

With this repository, you will be able to have a taste of crossplane and you can actually get your hands dirty as well.

## Docs

- [Why Crossplane](./docs/why-crossplane.md)
- [Why Not Terraform](./docs/why-not-terraform.md)
- [other docs](./docs)

## Take Off

### Prerequisites

- fork the this repository
- dependencies are currently defined at [./shell.nix](./shell.nix)
- and [export your credentials](https://fluxcd.io/docs/get-started/#export-your-credentials)

### Run

`make provision`

### Apply Your Own Changes
- make sure you forked the repository instead of cloning the original repository
- `make fix-repo` to point your forked repo not the original repo
- commit and push to `flux` branch
-	verify fluxcd apply new changes

## Clean Up
`make delete`

### Code Style

- I try to minimize of imperative ways when it comes to both producing the code and using produced code
- for example, running multiple commands to install this and that
- I'm a big beliver on declarative programming and a big fan of relying on automated procedures
- that's also why there is a heavy usage on `kustomize` and `fluxcd` and even `nix`
- I want tools to do the job for me because they are better at it.
