with import <nixpkgs> {};
with pkgs.python310Packages;

buildPythonPackage rec {
  name = "gradient-free-optimizers";
  src = fetchFromGitHub {
    owner = "SimonBlanke";
    repo = "Gradient-Free-Optimizers";
    rev = "5c025aeccf5c5ed1f51765c98e3b1b81012312cb";
    sha256 = "sha256-vClFUqPOOSrnXtce6+JLVRUqW1A7EHYbxn0EGRoW7r4=";
  };
  doCheck = false;
  propagatedBuildInputs = [ 
      python310Packages.tqdm
      python310Packages.scipy
      python310Packages.numpy
      python310Packages.pandas
      python310Packages.scikit-learn
  ];
}
