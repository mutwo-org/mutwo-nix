with import <nixpkgs> {};
with pkgs.python310Packages;


let

  mutwo-clock = import ../mutwo.clock/default.nix;

in

  buildPythonPackage rec {
    name = "mutwo.diary";
    src = fetchFromGitHub {
      owner = "levinericzimmermann";
      repo = name;
      rev = "45e2efa1f42a315b87470b52abf2140fd480d87f";
      sha256 = "sha256-zMqV5nIGap19pR3+/7C1t7G1hPFZCmhlC/nLA9gyOXw=";
    };
    checkInputs = [
      python310Packages.pytest
    ];
    propagatedBuildInputs = [ 
      python310Packages.zodb
      mutwo-clock
      python310Packages.numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
