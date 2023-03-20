{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  mutwo-core = import ../mutwo.core/default.nix {};
  python-ranges = import ../python-ranges/default.nix {};
  treelib = import ../treelib/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.common";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "dd8b4e5355cb0bacb0085146f975e620a6384abe";
      sha256 = "sha256-L0ruY6ehQFwXnxqq5iY+DF9RTURcI5E+e6NGMFULEoQ=";
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
