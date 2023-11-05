{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

buildPythonPackage rec {
  name = "panphon";
  src = fetchFromGitHub {
    owner = "dmort27";
    repo = name;
    rev = "f66df90e179179696e21991993bf06b8e9cebfba";
    sha256 = "sha256-uKiTOJ3pPy1mZQHNPsEaomXPWRSClSGoY7dpa11lAuI=";
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
