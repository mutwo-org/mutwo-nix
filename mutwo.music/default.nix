{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-common = import ../mutwo.common/default.nix {};
  epitran = import ../epitran/default.nix {};
  gradient-free-optimizers = import ../gradient-free-optimizers/default.nix {};

  origin = sources.mutwo-music;

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
      numpy
      scipy
      sympy
      # XXX: Currently nix-build doesn't work with ortools, see
      #   https://discourse.nixos.org/t/ortools-module-not-found-under-nix-shell/14190/7
      # and
      #   https://stackoverflow.com/questions/68477623/ortools-not-found-in-nix-shell
      #
      # If you want to use ortools specific functionalities, specify in shell.nix.
      # python310Packages.ortools
      gradient-free-optimizers
      mutwo-common
      epitran
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      pytest --doctest-modules mutwo
      runHook postCheck
    '';
    doCheck = true;
  }
