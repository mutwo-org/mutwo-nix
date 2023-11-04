{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

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
      unicodecsv
      pyyaml
      regex
      editdistance
      numpy
      munkres
      setuptools
  ];
}
