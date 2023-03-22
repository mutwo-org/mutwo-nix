{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;


let

  pyo = import ../pyo/default.nix {};

  origin = sources.walkman;

in

  buildPythonPackage rec {
    name = "audiowalkman";
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
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
