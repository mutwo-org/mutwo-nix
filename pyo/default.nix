{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

buildPythonPackage rec {
  name = "pyo";
  src = fetchFromGitHub {
    owner = "belangeo";
    repo = "pyo";
    rev = "360c429138e170e291a89da605a8dc20f837466f";
    sha256 = "sha256-CRHl+lAdiDXrXVcr9W14XE9lTJ6T7MfE8WeTMm6FpzU=";
  };
  doCheck = false;
  setupPyGlobalFlags = [
      "--use-double"
      "--use-jack"
  ];
  propagatedBuildInputs = with pkgs; [ 
    # C library dependencies for pyo
    portaudio
    libsndfile
    portmidi
    liblo
    alsa-lib
    alsa-utils
    libjack2
    flac
    libogg
    libvorbis
    # Other pyo dependencies
    wxPython_4_2
  ];
}
