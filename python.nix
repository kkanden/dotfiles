{ pkgs, ... }:
let
  py-packages =
    python-pkgs: with python-pkgs; [
      black
      isort
      streamlit
      pylatexenc
      polars
      pandas
      numpy
    ];
in
{
  home.packages = [
    (pkgs.python313.withPackages py-packages)
  ];
}
