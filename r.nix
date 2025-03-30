{ pkgs, ... }:
let
  r-packages =
    with pkgs.rPackages;
    [
      languageserver
      data_table
      tidyverse
      stringi
      DBI
      DT
      shiny
      shinyWidgets
      shinyalert
      bsicons
      plotly
      shinytitle
      RPostgres
      gt
      pacman
      ellipse
    ]
    ++ [ pkgs.rPackages.config ]; # have to separate to avoid conflict with variable;
in
{
  home.packages = [
    (pkgs.rWrapper.override { packages = r-packages; }) # R
  ];
}
