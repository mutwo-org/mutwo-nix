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
      rev = "e2ea3cd84ea91b5abc4142ff467ddc77f6a241c3";
      sha256 = "sha256-Sc9FBoOXUcgYT2plQMsgD/KE9ZdT3jb54RSHIwcSwaQ=";
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
