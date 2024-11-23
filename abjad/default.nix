{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;


let

  args = {sources=sources; pkgs=pkgs; pythonPackages=pythonPackages;};
  quicktions = import ../quicktions/default.nix args;
  uqbar = import ../uqbar/default.nix args;

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


in

  buildPythonPackage rec {
    name = "abjad";
    src = fetchPypi {
      pname = name;
      version = "3.11";
      sha256 = "sha256-UKbid5TrtsXoasJzWawwV8A9RWbuu+pxnLRLRRuOR+U=";
    };
    patchPhase = ''
        # Remove useless sphinx-autodoc-typehints dependency.
        #     (we don't need to build docs here)
        # See:
        #   https://github.com/Abjad/abjad/blob/v3.7/setup.py#L84
        sed -i '84d' setup.py
    '';
    nativeCheckInputs = [
        lilypond
        pytest
    ];
    checkInputs = [
        lilypond
        pytest
    ];
    checkPhase = ''
      runHook preCheck
      pytest
      pytest --doctest-modules abjad
      runHook postCheck
    '';
    propagatedBuildInputs = [
      quicktions
      uqbar
      ply
      black
      flake8
      isort
      mypy
      pytest
      pytest-cov
      roman
      six
      pytest-helpers-namespace
    ];
    doCheck = true;
  }
