{}:

let

  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  pythonPackages = pkgs.python39Packages;

in

  import ./default.nix {sources=sources;pkgs=pkgs;pythonPackages=pythonPackages;}
