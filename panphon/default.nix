{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

buildPythonPackage rec {
  name = "panphon";
  src = fetchFromGitHub {
    owner = "dmort27";
    repo = name;
    rev = "43389ed78b405412b3eee448875969de7a18b78a";
    sha256 = "sha256-HYdqoAYkbgMLbuWoSjUGKArkfvLEQmILVdJvvo3N9mg=";
  };
  propagatedBuildInputs = [ 
      flite
      python310Packages.unicodecsv
      python310Packages.pyyaml
      python310Packages.regex
      python310Packages.editdistance
      python310Packages.numpy
      python310Packages.munkres
      python310Packages.setuptools
  ];
}
