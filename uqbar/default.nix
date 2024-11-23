{ sources ? import ../nix/sources.nix, pkgs ? import sources.nixpkgs {}, pythonPackages ? pkgs.python311Packages}:
with pkgs;
with pythonPackages;


buildPythonPackage rec {
name = "uqbar";
src = fetchFromGitHub {
  owner = "josiah-wolf-oberholtzer";
  repo = "uqbar";
  rev = "0390d3b1f4cd74c238ee038960ed8d69986a1a9a";
  sha256 = "sha256-WSX+XKFlPvUNmN161UweEWiP+EXOJPHEfziUer8dpzA=";
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
  sphinx_rtd_theme
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
];
doCheck = true;
}
