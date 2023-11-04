{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  mutwo-timeline = import ../mutwo.timeline/default.nix args;
  mutwo-abjad = import ../mutwo.abjad/default.nix args;
  mutwo-common = import ../mutwo.common/default.nix args;
  treelib = import ../treelib/default.nix args;

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
    checkInputs = [
      pytest
      lilypond-with-fonts
    ];
    propagatedBuildInputs = [ 
      mutwo-timeline
      mutwo-abjad
      mutwo-common
      lilypond-with-fonts
      treelib
      numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
