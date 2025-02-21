{pkgs, ...}: let
  overlay1 = final: prev: let
    bslib = prev.rPackages.buildRPackage {
      name = "bslib";
      src = prev.fetchFromGitHub {
        owner = "rstudio";
        repo = "bslib";
        rev = "ee34398b1d93056c302560512a090c1326aff7cf";
        sha256 = "18vwabri5fxl3hkmy02cmidy8vbiqvglnnxiqg9ibg5s141j63vq";
      };
      propagatedBuildInputs = with prev.rPackages; [
        base64enc
        cachem
        fastmap
        htmltools
        jquerylib
        jsonlite
        lifecycle
        memoise
        mime
        rlang
        sass
      ];
    };
  in {
    rPackages = prev.rPackages // {inherit bslib;};
  };
  pkgs_r = pkgs.extend overlay1;
  r-packages = with pkgs_r.rPackages;
    [
      base64enc
      cachem
      fastmap
      htmltools
      jquerylib
      jsonlite
      lifecycle
      memoise
      mime
      rlang
      sass
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
    ]
    ++ [pkgs.rPackages.config]; # have to separate to avoid conflict with variable;
in {
  home.packages = [
    (pkgs.rWrapper.override {packages = r-packages;}) # R
  ];
}
