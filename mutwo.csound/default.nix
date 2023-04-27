{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-core = import ../mutwo.core/default.nix {};
  origin = sources.mutwo-csound;

in

  buildPythonPackage rec {
    name = origin.repo;
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [
        csound
        pytest
    ];
    checkInputs = [
        csound
        pytest
    ];
    propagatedBuildInputs = [ 
      csound
      mutwo-core
      natsort
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      pytest --doctest-modules mutwo
      runHook postCheck
    '';
    doCheck = true;
  }
