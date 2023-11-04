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
      version = "3.7";
      sha256 = "sha256-+RHZPQQPNCv2AJKHX+8YEif4ZFS/2XuUO17EsY+Qg5Q=";
    };
    doCheck = true;
    propagatedBuildInputs = [
      abjad
    ];
  }
