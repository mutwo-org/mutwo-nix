{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

buildPythonPackage rec {
  name = "quicktions";
  src = fetchPypi {
    pname = name;
    version = "1.13";
    sha256 = "sha256-HzmMN1sAUjsSgy7vNvX/hq49LZmSnTQYbamjRoXeaL0=";
  };
  doCheck = true;
  propagatedBuildInputs = [
    cython_3
    codecov
  ];
}
