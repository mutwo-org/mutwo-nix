with import <nixpkgs> {};
with pkgs.python310Packages;

let

  mutwo-timeline = import ../mutwo.timeline/default.nix;
  mutwo-abjad = import ../mutwo.abjad/default.nix;
  treelib = import ../treelib/default.nix;

in

  buildPythonPackage rec {
    name = "mutwo.clock";
    src = fetchFromGitHub {
      owner = "levinericzimmermann";
      repo = name;
      rev = "114f3912a0d9b07bc238495d739ac61dceac66a6";
      sha256 = "sha256-9Wvn3IEZpy9fY1q9CmhSHjYuQdfhCo0HKumw0T7CtjU=";
    };
    checkInputs = [
      python310Packages.pytest
      lilypond-with-fonts
    ];
    propagatedBuildInputs = [ 
      mutwo-timeline
      mutwo-abjad
      lilypond-with-fonts
      treelib
      python310Packages.numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
