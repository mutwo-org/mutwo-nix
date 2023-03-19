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
      rev = "9f1d87dbd3f0519dca0d63abe54b3eb6eacdcb19";
      sha256 = "sha256-0SRzWtf+IWrcaYbT6ySXgJ2IMl7ED2zJttxOsXFC0gw=";
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
