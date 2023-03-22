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
      rev = "f4a6dee2cd093de6e4f387fd45d9bdb21ba607c9";
      sha256 = "sha256-fnCpntTEdqjHXmu1HC3o1NKv31V39SmXl3skHZOJqCg=";
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
