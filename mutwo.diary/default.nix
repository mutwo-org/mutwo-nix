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
      rev = "45e2efa1f42a315b87470b52abf2140fd480d87f";
      sha256 = "sha256-zMqV5nIGap19pR3+/7C1t7G1hPFZCmhlC/nLA9gyOXw=";
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
