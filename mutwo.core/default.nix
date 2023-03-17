with import <nixpkgs> {};
with pkgs.python310Packages;

let

  python-ranges = import ../python-ranges/default.nix;
  quicktions = import ../quicktions/default.nix;

in

  buildPythonPackage rec {
    name = "mutwo.core";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "7fc579e123b24c16a63990fb24cae0af635b8f7b";
      sha256 = "sha256-aiyB1xKSH2B/vrhZaYn3Vql/5I/NfVR4u38DztpZDd0=";
    };
    checkInputs = [
      python310Packages.pytest
    ];
    propagatedBuildInputs = [ 
      python310Packages.numpy
      python310Packages.scipy
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
