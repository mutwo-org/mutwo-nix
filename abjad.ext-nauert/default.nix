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
      version = "3.9";
      sha256 = "sha256-e/iqJ0V2CJXHbJjRaZ070naxR1LE8kwc2VU3gmro7hw=";
    };
    doCheck = true;
    propagatedBuildInputs = [
      abjad
    ];
  }
