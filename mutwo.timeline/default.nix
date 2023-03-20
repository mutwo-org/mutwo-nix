{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-core = import ../mutwo.core/default.nix {};
  python-ranges = import ../python-ranges/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.timeline";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "b6b0864a99f369043d69464e63d22796aeda3c79";
      sha256 = "sha256-jJaTgORcm61DUfePK5/pZ7MiZxCk1knen9ul7c9ZpfI=";
    };
    nativeCheckInputs = [
      python310Packages.pytest
    ];
    propagatedBuildInputs = [ 
      python310Packages.numpy
      mutwo-core
      python-ranges
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
