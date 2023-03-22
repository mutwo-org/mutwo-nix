{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  mutwo-core = import ../mutwo.core/default.nix {};
  python-ranges = import ../python-ranges/default.nix {};
  treelib = import ../treelib/default.nix {};

  origin = sources.mutwo-common;

in

  buildPythonPackage rec {
    name = origin.repo;
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [ pytest ];
    propagatedBuildInputs = [ 
      treelib
      numpy
      scipy
      python-ranges
      mutwo-core
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
