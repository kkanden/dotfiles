{ pkgs, ... }:
let
  py-packages =
    python-pkgs: with python-pkgs; [
      black
      isort
      # streamlit
      pylatexenc
      polars
      pandas
      numpy
      jupyter
    ];
in
{
  home.packages = [
    (pkgs.python313.withPackages py-packages)
  ];
}
