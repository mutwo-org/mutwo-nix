{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;


buildPythonPackage rec {
name = "uqbar";
src = fetchFromGitHub {
  owner = "supriya-project";
  repo = "uqbar";
  rev = "4739d51c9b8fb0bc08000de6d858cfe24fd00517";
  sha256 = "sha256-utYV2+SST6Gg2DFmk75PPjdTwcM6+8tLSjbYCmg1V9U=";
};
nativeCheckInputs = [ pkgs.graphviz pytest ];
checkInputs = [ pkgs.graphviz pytest ];
checkPhase = ''
  runHook preCheck
  pytest -k "not test_call_help and not test_help and not test_interpret_code_blocks_02 and not test_sphinx_api_1 and not test_sphinx_book_text_cached and not test_sphinx_book_text_uncached and not test_sphinx_book_text_broken_strict and not test_03 and not test_str_04 and not test_sphinx_api_2 and not test_sphinx_style_html and not test_sphinx_style_latex and not test_sphinx_style_1"
  runHook postCheck
'';
propagatedBuildInputs = [
  # python dependencies
  sphinx-rtd-theme
  flake8
  isort
  mypy
  pytest
  pytest-cov
  unidecode
  sphinx
  black
  sphinx-autodoc-typehints
  # non python dependencies
  pkgs.graphviz
  # py>=3.12 compatibility
  distutils
];
doCheck = false;
build-system = [ setuptools ];
pyproject = true;
}
