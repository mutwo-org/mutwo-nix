{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  mutwo-timeline = import ../mutwo.timeline/default.nix {};
  mutwo-abjad = import ../mutwo.abjad/default.nix {};
  treelib = import ../treelib/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.clock";
    src = fetchFromGitHub {
      owner = "levinericzimmermann";
      repo = name;
      rev = "6108af28b5f8587ec1a1a9f807aee81056abe7bb";
      sha256 = "sha256-TExbqXZm92VTIonXbSH4fLwhOivlNjIC2y658LrxbvI=";
    };
    nativeCheckInputs = [
      pytest
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
