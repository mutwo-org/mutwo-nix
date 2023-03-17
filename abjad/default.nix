with import <nixpkgs> {};
with pkgs.python310Packages;

let

  quicktions = import ../quicktions/default.nix;

  sphinx-autodoc-typehints = buildPythonPackage rec {
    name = "sphinx-autodoc-typehints";
    src = fetchPypi {
      pname = "sphinx_autodoc_typehints";
      version = "1.18.3";
      sha256 = "sha256-wE2PjXDpiJYOJbIGrzmpDfhOfiwIW7JOEjvDaEAhsxM=";
    };
    propagatedBuildInputs = [
      python310Packages.sphinx
    ];
    doCheck = true;
  };

  ply = buildPythonPackage rec {
    name = "ply";
    src = fetchFromGitHub {
      owner = "dabeaz";
      repo = name;
      rev = "0f398b72618c1564d71f7dc0558e6722b241875a";
      sha256 = "sha256-PEwIgmM7DQHy6FOhcUwkricrdW3wZe3ggSQnUvgKISo=";
    };
    doCheck = true;
  };

  uqbar = buildPythonPackage rec {
    name = "uqbar";
    src = fetchPypi {
      pname = name;
      version = "0.5.9";
      sha256 = "sha256-0G02Amj8qB81DD0E1whPNYq9xfU6JeXrKuEW8F9HhQY=";
    };
    propagatedBuildInputs = [
      python310Packages.sphinx_rtd_theme
      python310Packages.flake8
      python310Packages.isort
      python310Packages.mypy
      python310Packages.pytest
      python310Packages.pytest-cov
      python310Packages.unidecode
      python310Packages.sphinx
      python310Packages.black
      sphinx-autodoc-typehints
    ];
    doCheck = false;
  };

in

  buildPythonPackage rec {
    name = "abjad";
    src = fetchPypi {
      pname = name;
      version = "3.7";
      sha256 = "sha256-3N/Z6UgBG8Wi+hWKvuBWss42rlwaivsmHlrfr+Y8/us=";
    };
    patchPhase = ''
        # Remove useless sphinx-autodoc-typehints dependency.
        #     (we don't need to build docs here)
        # See:
        #   https://github.com/Abjad/abjad/blob/v3.7/setup.py#L84
        sed -i '84d' setup.py
    '';
    propagatedBuildInputs = [
      quicktions
      uqbar
      ply
      python310Packages.black
      python310Packages.flake8
      python310Packages.isort
      python310Packages.mypy
      python310Packages.pytest
      python310Packages.pytest-cov
      python310Packages.roman
      python310Packages.six
      python310Packages.pytest-helpers-namespace
    ];
    doCheck = false;
  }
