{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

buildPythonPackage rec {
  name = "panphon";
  src = fetchFromGitHub {
    owner = "dmort27";
    repo = name;
    rev = "0500057b81f2f663bb7767745c3b0075551e2b7c";
    sha256 = "sha256-X32JVgKkYPGE+BcLnF3l9Jpq6TqVYyFUzKF3lp1eJD8=";
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
