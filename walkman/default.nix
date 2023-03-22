{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  pyo = import ../pyo/default.nix {};

in

  buildPythonPackage rec {
    name = "audiowalkman";
    src = fetchFromGitHub {
      owner = "audiowalkman";
      repo = "walkman";
      rev = "db6ac87453b5136b9fa799bdcad06d738a68a4aa";
      sha256 = "sha256-k9PfLmIr8tXCugsyPzFeCGZ0bDIpy0D+nvPiARP9h7Q=";
    };
    propagatedBuildInputs = [ 
      pyo
      pysimplegui
      click
      tomli
      jinja2
    ];
    nativeCheckInputs = [
      pytest
    ];
    doCheck = true;
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
  }
