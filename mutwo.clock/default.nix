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
      rev = "3c1454034f0e2fb2a23d47a23de83ae38216dadc";
      sha256 = "sha256-IAbn5dqYhCgp+BvUwE/6Bs7FLVz55wcXyIyIoTNhmls=";
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
