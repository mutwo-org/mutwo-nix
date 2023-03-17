with import <nixpkgs> {};
with pkgs.python310Packages;


let
  panphon = import ../panphon/default.nix;
in
  buildPythonPackage rec {
    name = "epitran";
    src = fetchFromGitHub {
      owner = "dmort27";
      repo = name;
      rev = "a30eef02327af0f5f1d161fa427f9e56545b3b64";
      sha256 = "sha256-AH4q8J5oMaUVJ559qe/ZlJXlCcGdxWnxMhnZKCH5Rlk=";
    };
    propagatedBuildInputs = [ 
        flite
        python310Packages.setuptools
        python310Packages.regex
        python310Packages.marisa-trie
        python310Packages.requests
        panphon
    ];
  }
