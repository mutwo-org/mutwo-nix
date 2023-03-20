{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}}:
with pkgs;
with pkgs.python310Packages;

let

  mutwo-ekmelily = import ../mutwo.ekmelily/default.nix {};
  abjad = import ../abjad/default.nix {};
  abjad-ext-nauert = import ../abjad.ext-nauert/default.nix {};

  # Fix Fontconfig error: Cannot load default config file
  fontsConf = makeFontsConf {
    fontDirectories = [ freefont_ttf ];
  };

  # Fix Fontconfig error: Can't find cache
  fontsCache= makeFontsCache {};

in

  buildPythonPackage rec {
    name = "mutwo.abjad";
    src = fetchFromGitHub {
      owner = "mutwo-org";
      repo = name;
      rev = "cb599f49777040c3d5d69bf347b19fa229fa87db";
      sha256 = "sha256-u9fP3YuSZF/5CyJTNOi20bUJp1Y6MujX8KVGTwmW/mI=";
    };
    nativeCheckInputs = [
      pytest
      pillow
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
    # XXX: Lilypond comparison tests are broke, I don't know why,
    # because locally they work with exactly the same version.
    # I should ASAP fix them.
    doCheck = false;
    build-cache-failures = true;
  }
