{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python310Packages}:
with pkgs;
with pythonPackages;

buildPythonPackage rec {
  name = "python-ranges";
  src = fetchPypi {
    pname = name;
    version = "1.2.2";
    sha256 = "sha256-eZYYBGYDlUp4q0YR0hCA04ez6cUMGBeJ45A9Ygmia5g=";
  };
  # TypeError: calling <class 'ranges.RangeDict.RangeDict'> returned {}, not a test
  doCheck = true;
  checkInputs = [ pytest ];
  nativeCheckInputs = [ pytest ];
  checkPhase = ''
    runHook preCheck
    pytest
    runHook postCheck
  '';
  patchPhase = ''
      # readme.md isn't found, needed in setup.py?
      touch readme.md
  '';
}
