{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  abjad = import ../abjad/default.nix args;

in

  buildPythonPackage rec {
    name = "abjad-ext-nauert";
    pyproject = true;
    src = fetchPypi {
      pname = name;
      version = "3.8";
      sha256 = "sha256-46mypf0BDpSIeLNugC5WomcMpO36vZPynqUyd2t40u4=";
    };
    doCheck = true;
    propagatedBuildInputs = [
      abjad
    ];
  }
