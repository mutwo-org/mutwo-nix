{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

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
