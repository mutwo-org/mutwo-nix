{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-clock = import ../mutwo.clock/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.diary";
    src = fetchFromGitHub {
      owner = "levinericzimmermann";
      repo = name;
      rev = "29cc798b6c4da04ba24b0c753fd63275aa675e81";
      sha256 = "sha256-Teu/z8mMWoiZHytjddGSnkSP178bvllkoVNr+NjxndM=";
    };
    nativeCheckInputs = [
      pytest
    ];
    propagatedBuildInputs = [ 
      mutwo-clock
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
