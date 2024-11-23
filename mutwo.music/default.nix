{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  mutwo-core = import ../mutwo.core/default.nix args;
  epitran = import ../epitran/default.nix args;
  python-ranges = import ../python-ranges/default.nix args;

  origin = sources.mutwo-music;

in

  buildPythonPackage rec {
    name = origin.repo;
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [ pytest ];
    checkInputs = [ pytest ];
    propagatedBuildInputs = [ 
      mutwo-core
      python-ranges
      sympy
      epitran
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      pytest --doctest-modules mutwo
      runHook postCheck
    '';
    doCheck = true;
  }
