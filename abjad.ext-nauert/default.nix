{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  abjad = import ../abjad/default.nix {};

in

  buildPythonPackage rec {
    name = "abjad-ext-nauert";
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
