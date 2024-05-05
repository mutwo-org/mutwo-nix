{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  mutwo-core = import ../mutwo.core/default.nix args;
  mutwo-common = import ../mutwo.common/default.nix args;
  mutwo-timeline = import ../mutwo.timeline/default.nix args;
  origin = sources.mutwo-diary;

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
    ];
    checkInputs = [
      pytest
    ];
    propagatedBuildInputs = [ 
      mutwo-core
      mutwo-common
      mutwo-timeline
      zodb
      numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
