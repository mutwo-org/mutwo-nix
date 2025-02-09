{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};

  mutwo-abjad     = import ../mutwo.abjad/default.nix args;
  mutwo-core      = import ../mutwo.core/default.nix args;
  mutwo-common    = import ../mutwo.common/default.nix args;
  mutwo-csound    = import ../mutwo.csound/default.nix args;
  mutwo-ekmelily  = import ../mutwo.ekmelily/default.nix args;
  mutwo-midi      = import ../mutwo.midi/default.nix args;
  mutwo-mmml      = import ../mutwo.mmml/default.nix args;
  mutwo-music     = import ../mutwo.music/default.nix args;
  mutwo-reaper    = import ../mutwo.reaper/default.nix args;
  mutwo-timeline  = import ../mutwo.timeline/default.nix args;

  origin = sources.m2;

in

  buildPythonPackage rec {
    name = "m2";
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [ pytest ];
    checkInputs = [ pytest ];
    propagatedBuildInputs = [ 
        mutwo-abjad
        mutwo-core
        mutwo-common
        mutwo-csound
        mutwo-ekmelily
        mutwo-midi
        mutwo-mmml
        mutwo-music
        mutwo-reaper
        mutwo-timeline
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
    format = "pyproject";
  }
