{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

buildPythonPackage rec {
  name = "python-ranges";
  src = fetchFromGitHub {
    owner = "Superbird11";
    repo = "ranges";
    rev = "38ac789b61e1e33d1a8be999ca969f909bb652c0";
    sha256 = "sha256-oRQCtDBQnViNP6sJZU0NqFWkn2YpcIeGWmfx3Ne/n2c=";
  };
  # TypeError: calling <class 'ranges.RangeDict.RangeDict'> returned {}, not a test
  doCheck = false;
  checkInputs = [ python310Packages.pytest ];
}
