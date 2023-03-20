{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-common = import ../mutwo.common/default.nix {};
  epitran = import ../epitran/default.nix {};
  gradient-free-optimizers = import ../gradient-free-optimizers/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.music";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "24d4d2c2001431119e64eeb6fd003f287dee58e3";
      sha256 = "sha256-lSjwk1rbFQDfjXQ2yGUqKmye1w1Q4X0gX/ZUi8D/o28=";
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
