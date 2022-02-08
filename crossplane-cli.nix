# this derivation is based on https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh
{ pkgs }:

with pkgs; let
  artifactVersion = "v1.6.2";
  systemSelector = builtins.currentSystem;
  corespondentArtifact = { # mimic switch case or match
    x86_64-darwin = {
      os_arch = "darwin_amd64";
      sha256 = "l4wj/yVSJ1rUMmAmovi25+vzmzREa9z5uVQa56gMDlk=";
    };
    aarch64-darwin = {
      os_arch = "darwin_arm64";
      sha256 = "TQQCSQLCvvXLobiCbCPzHKNlRNmZ7LPKAAZLgN1/pw8=";
    };
    x86_64-linux = {
      os_arch = "linux_amd64";
      sha256 = "SeGIszT/7w77N4qJM1g7F9MGdj/oufSEfhQz+zMdmAM=";
    };
    aarch64-linux = {
      os_arch = "linux_arm64";
      sha256 = "E/aA0vH/7ZJAPbXqsRDF8cbLBXhCnFWGrlEygtSPGIA=";
    };
  }.${systemSelector} or {};
  os_arch = corespondentArtifact.os_arch;
  artifactSha256 = corespondentArtifact.sha256;
in
  # https://ops.functionalalgebra.com/nix-by-example/
  if builtins.hasAttr "sha256" corespondentArtifact then
  stdenv.mkDerivation rec {
    name = "crossplane-cli";
    version = "${artifactVersion}";

    src = fetchurl {
      url = "https://releases.crossplane.io/stable/${artifactVersion}/bin/${os_arch}/crank";
      sha256 = "${artifactSha256}";
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/bin
      cp ${src} $out/bin/kubectl-crossplane
      chmod +x $out/bin/kubectl-crossplane
    '';
  }
  else
  builtins.throw ''
    Failed to install crossplane cli.
    "${systemSelector}" system is not supported this nix derivation.
  ''

