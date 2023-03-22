{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-clock = import ../mutwo.clock/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.diary";
    src = fetchFromGitHub {
      owner = "levinericzimmermann";
      repo = name;
      rev = "32d8b57d04ca195b32a933521cefa59db88565c2";
      sha256 = "sha256-xGjcAR0BloX77M02zspz35/DPjmT1PVb9305X7cR0Xk=";
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
