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
      rev = "528e5c47577fade937d2918b621822cd71f6a0b9";
      sha256 = "sha256-yCm4s7DNN3XobEmt8+Zf93jgR1KampQkkMIYSW4feTA=";
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
