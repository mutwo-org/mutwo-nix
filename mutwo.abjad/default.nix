with import <nixpkgs> {};
with pkgs.python310Packages;

let

  mutwo-ekmelily = import ../mutwo.ekmelily/default.nix;
  abjad = import ../abjad/default.nix;
  abjad-ext-nauert = import ../abjad.ext-nauert/default.nix;

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
      rev = "23e0efae966ca9f28dfee6508cf6b409237734df";
      sha256 = "sha256-BepRE+ZZkygW3W/tlm2jwfkTE5Cx6te3IDaT51tj/Is=";
    };
    checkInputs = [
      python310Packages.pytest
      python310Packages.pillow
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
