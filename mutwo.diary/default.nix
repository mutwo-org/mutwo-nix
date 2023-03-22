{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {} }:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-clock = import ../mutwo.clock/default.nix {};
  origin = sources.mutwo-diary;

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
      pytest
    ];
    propagatedBuildInputs = [ 
      mutwo-clock
      zodb
      numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
