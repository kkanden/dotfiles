{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  r-packages = with pkgs.rPackages; [
    languageserver
    data_table
    tidyverse
    stringi
  ];
  py-packages = python-pkgs:
    with python-pkgs; [
      black
      isort
    ];
in {
  home.username = "oliwia";
  home.homeDirectory = "/home/oliwia";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages =
    lib.attrValues {
      inherit
        (pkgs)
        # tools
        gcc
        diffutils
        which
        gnumake
        fd
        fzf
        bat
        jq
        gh
        postgresql_17
        # cli
        neovim
        cowsay
        lolcat
        fastfetch
        spotify-player
        # langs
        rustup
        nodejs_23
        # formatters
        alejandra
        stylua
        ;

      inherit
        (pkgs.nodePackages)
        prettier
        ;
    }
    ++ [
      (pkgs.rWrapper.override {packages = r-packages;}) # R
      (pkgs.python313.withPackages py-packages) # python
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "oliwia";
    userEmail = "24637207+kkanden@users.noreply.github.com";
    aliases = {
      lg = "log --oneline --graph --all --decorate --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(yellow)%h%Creset - %C(blue)%an <%ae>%Creset - %C(green)%ad%Creset -%C(red)%d%Creset %s'";
    };
    extraConfig = {
      init.defaultbranch = "main";
      core.editor = "nvim";
      core.autocrlf = false;
    };
  };

  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
    ];
  };

  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (
        builtins.readFile (
          builtins.path {
            path = ../.config/.my-omp.omp.json; # path relative to home.nix
          }
        )
      )
    );
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      r = "R";
      gs = "git status";
      la = "ls -la";
      nixh = "nvim ~/dotfiles/.config/home-manager/home.nix";
    };
    functions = {
      home = {
        body =
          # fish
          ''
            if test (count $argv) -eq 0
              set argv[1] "switch"
            end
              pushd ~/dotfiles
              home-manager --flake . $argv[1]
              popd
          '';
      };
    };
    interactiveShellInit =
      # fish
      ''
        function fish_greeting
        end
      '';
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
