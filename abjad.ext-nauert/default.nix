{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  abjad = import ../abjad/default.nix args;

in

  buildPythonPackage rec {
    name = "abjad-ext-nauert";
    src = fetchPypi {
      pname = name;
      version = "3.11";
      sha256 = "sha256-Io+vYuCaILeiI+mB61YfrLYFMIWbSNtL6H4OBW7oYmg=";
    };
    doCheck = true;
    propagatedBuildInputs = [
      abjad
    ];
  }
