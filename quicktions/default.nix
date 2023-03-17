with import <nixpkgs> {};
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
    python310Packages.cython_3
    python310Packages.codecov
  ];
}
