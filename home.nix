{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # air = pkgs.callPackage ./air.nix inputs;
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
        ripgrep
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
      # air
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/oliwia/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    EDITOR = "nvim";
    RIPGREP_CONFIG_PATH = "$HOME/.config/.ripgreprc";
  };

  # programs.bash = {
  #   initExtra = ''
  #     if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
  #     then
  #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
  #     fi
  #   '';
  # };

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

  programs.oh-my-posh = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit =
      # sh
      ''
        source ~/.config/fish/myconfig.fish
      '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
