{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;

let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  mutwo-ekmelily = import ../mutwo.ekmelily/default.nix args;
  abjad = import ../abjad/default.nix args;
  abjad-ext-nauert = import ../abjad.ext-nauert/default.nix args;

  # Fix Fontconfig error: Cannot load default config file
  fontsConf = makeFontsConf {
    fontDirectories = [ freefont_ttf ];
  };

  # Fix Fontconfig error: Can't find cache
  fontsCache = makeFontsCache {};

  origin = sources.mutwo-abjad;

in

  buildPythonPackage rec {
    name = origin.repo;
    src = fetchFromGitHub {
      owner = origin.owner;
      repo = origin.repo;
      rev = origin.rev;
      sha256 = origin.sha256;
    };
    nativeCheckInputs = [
      pytest
      lilypond-with-fonts
    ];
    checkInputs = [
      pytest
      lilypond-with-fonts
    ];
    propagatedBuildInputs = [
      abjad
      abjad-ext-nauert
      mutwo-ekmelily
      lilypond-with-fonts
    ];
    checkPhase = ''
      runHook preCheck
      export FONTCONFIG_FILE=${fontsConf};
      pytest
      runHook postCheck
    '';
    doCheck = true;
    build-cache-failures = true;
  }
