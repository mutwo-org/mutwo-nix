{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

buildPythonPackage rec {
  name = "treelib";
  src = fetchFromGitHub {
    owner = "caesar0301";
    repo = name;
    rev = "12d7efd50829a5a18edaab01911b1e546bff2ede";
    sha256 = "sha256-QGgWsMfPm4ZCSeU/ODY0ewg1mu/mRmtXgHtDyHT9dac=";
  };
  doCheck = true;
  propagatedBuildInputs = [ future ];
}
