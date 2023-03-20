{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  python-ranges = import ../python-ranges/default.nix {};
  quicktions = import ../quicktions/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.core";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "7fc579e123b24c16a63990fb24cae0af635b8f7b";
      sha256 = "sha256-aiyB1xKSH2B/vrhZaYn3Vql/5I/NfVR4u38DztpZDd0=";
    };
    nativeCheckInputs = [ pytest ];
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
