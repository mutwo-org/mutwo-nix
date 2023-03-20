{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-music = import ../mutwo.music/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.midi";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "5cf9609b84fb51811bc3d746b32e40e325427a4d";
      sha256 = "sha256-dgnV3DbDFMCCrst9lfYDXoRz0RW+2jGNhZ6e4YoVkc4=";
    };
    nativeCheckInputs = [
      pytest
    ];
    propagatedBuildInputs = [
      mutwo-music
      mido
      numpy
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
