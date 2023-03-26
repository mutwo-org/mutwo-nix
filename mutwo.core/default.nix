{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  python-ranges = import ../python-ranges/default.nix {};
  quicktions = import ../quicktions/default.nix {};

  origin = sources.mutwo-core;

in

  buildPythonPackage rec {
    name = "mutwo.core";
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [ pytest ];
    checkInputs = [ pytest ];
    propagatedBuildInputs = [ 
      numpy
      scipy
      python-ranges
      quicktions
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      pytest --doctest-modules mutwo
      runHook postCheck
    '';
    doCheck = true;
  }
