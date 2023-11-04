{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

buildPythonPackage rec {
  name = "quicktions";
  src = fetchPypi {
    pname = name;
    version = "1.15";
    sha256 = "sha256-K8NXZoJm2fyQL6iGykTJ2NPoq50q54ZflxvxBrT9HMM=";
  };
  doCheck = true;
  propagatedBuildInputs = [
    cython_3
    codecov
  ];
}
