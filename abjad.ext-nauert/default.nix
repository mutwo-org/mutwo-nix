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
      version = "3.10";
      sha256 = "sha256-9BF9keoGj9wThFaepwmfpRft/wI05fIuOTh3iuJv5nU=";
    };
    doCheck = true;
    propagatedBuildInputs = [
      abjad
    ];
  }
