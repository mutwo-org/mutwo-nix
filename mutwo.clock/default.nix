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
      rev = "59bac5e7bb3a21462621000322aea1654b0aac8e";
      sha256 = "sha256-YzDOgUGDB6JFWZBnfEJ6jb/V44VEKls6yQqjM0Q0t3Y=";
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
