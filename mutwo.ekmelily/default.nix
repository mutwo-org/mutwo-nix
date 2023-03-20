{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-music = import ../mutwo.music/default.nix {};

in

  buildPythonPackage rec {
    name = "mutwo.ekmelily";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "23331d320fa3957eeac0c12d1b664ad8c3265087";
      sha256 = "sha256-zg0sGbKVGCr0EfgU74FrNP66ljgPB/wVA0Kf4g/aaqQ=";
    };
    nativeCheckInputs = [ pytest ];
    propagatedBuildInputs = [
      mutwo-music
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      runHook postCheck
    '';
    doCheck = true;
  }
