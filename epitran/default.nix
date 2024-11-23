{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;

let
  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  panphon = import ../panphon/default.nix args;
in
  buildPythonPackage rec {
    name = "epitran";
    pyproject = true;
    src = fetchFromGitHub {
      owner = "dmort27";
      repo = name;
      rev = "a30eef02327af0f5f1d161fa427f9e56545b3b64";
      sha256 = "sha256-AH4q8J5oMaUVJ559qe/ZlJXlCcGdxWnxMhnZKCH5Rlk=";
    };
    propagatedBuildInputs = [ 
        flite
        setuptools
        regex
        marisa-trie
        requests
        panphon
    ];
  }
