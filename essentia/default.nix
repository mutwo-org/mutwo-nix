{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:

with pkgs;
with pkgs.python310Packages;

let

  origin = sources.essentia;

in

  buildPythonPackage rec {
    name = "essentia";
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    doCheck = false;
    patchPhase = ''
      ${python3}/bin/python waf configure --build-static --with-python
    '';
    nativeBuildInputs = [
      pkg-config
      curl
      eigen
      fftwFloat
      libyaml
      libsamplerate
    ];
    propagatedBuildInputs = with pkgs; [ 
      # C library dependencies for pyo
      eigen
      fftwFloat
      libyaml
      libsamplerate
      # Python dependencies
      numpy
      six
      pyyaml
    ];
  }
