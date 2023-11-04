{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  pyo = import ../pyo/default.nix args;

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
    checkInputs = [
      pytest
    ];
    doCheck = true;
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
  }
