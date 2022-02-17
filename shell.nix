{ pkgs ? import <nixpkgs> {} }:

let
  crossplane-cli = import ./crossplane-cli.nix { pkgs=pkgs; };
in
  pkgs.mkShell {
    buildInputs = with pkgs;[
      awscli2
      minikube
      kustomize
      kubectl
      kubernetes-helm
      fluxcd
      jq
      yq-go
      crossplane-cli
      act
    ];

  # Environment variables to set here - https://discourse.nixos.org/t/provide-environmental-variables-from-nix/3453/3
  DEBUG_NIX = builtins.currentSystem;
}
