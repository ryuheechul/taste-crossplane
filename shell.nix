{ pkgs ? import <nixpkgs> {} }:

let
  crossplane-cli = import ./crossplane-cli.nix { pkgs=pkgs; };
in
  pkgs.mkShell {
    buildInputs = with pkgs;[
      minikube
      kustomize
      kubectl
      kubernetes-helm
      fluxcd
      yq
      crossplane-cli
    ];

  # Environment variables to set here - https://discourse.nixos.org/t/provide-environmental-variables-from-nix/3453/3
  DEBUG_NIX = builtins.currentSystem;
}
