{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  mutwo-timeline = import ../mutwo.timeline/default.nix {};
  mutwo-abjad = import ../mutwo.abjad/default.nix {};
  treelib = import ../treelib/default.nix {};

  origin = sources.mutwo-clock;

in

  buildPythonPackage rec {
    name = origin.repo;
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
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
