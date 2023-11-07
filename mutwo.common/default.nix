{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  mutwo-core = import ../mutwo.core/default.nix args;
  python-ranges = import ../python-ranges/default.nix args;
  treelib = import ../treelib/default.nix args;

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
    checkInputs = [ pytest ];
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
      pytest --doctest-modules mutwo
      runHook postCheck
    '';
    doCheck = true;
  }
