{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  fish-pkg = pkgs.stable.fish;
in
{
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

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # basic tools
      neovim
      gcc
      diffutils
      which
      tree
      gnumake
      bat
      fontconfig
      wget
      unzip
      # additional tools
      fzf
      fd
      jq
      gh
      postgresql_17
      ffmpeg
      nix-prefetch-git
      tree-sitter
      pandoc
      texliveFull
      dust
      yarn
      # cosmetic
      cowsay
      lolcat
      fortune
      spotify-player
      # langs
      rustup
      nodejs_23
      jdk
      perl
      powershell
      php
      # lsp
      nixd
      fish-lsp
      # formatters
      alejandra
      nixfmt-rfc-style
      stylua
      tex-fmt
      air-formatter
      ;

    inherit (pkgs.nodePackages)
      prettier
      ;

    inherit (pkgs.fishPlugins)
      gruvbox
      ;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".Rprofile".source = ./config/.Rprofile;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;
    # enable fish shell as per https://nixos.wiki/wiki/Fish
    initExtra = ''
      source ~/dotfiles/config/ls_colors
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${fish-pkg}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    enable = true;
    package = fish-pkg;
    shellAliases = {
      r = "R";
      gs = "git status";
      la = "ls -la";
      nixh = "nvim ~/dotfiles/home.nix";
    };
    shellAbbrs = {
      tree = "tree -C";
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
        theme_gruvbox dark soft
        set fish_greeting

        bind \t accept-autosuggestion
        bind \cn complete-and-search

        source ~/.config/fish/theme.fish
        fortune | cowsay
      '';
  };
  xdg.configFile."fish/theme.fish".source = ./config/fish/kanagawa.fish;

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-Space";
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 10;
    focusEvents = true;
    mouse = true;
    terminal = "screen-256color";
    extraConfig = builtins.readFile ./config/tmux/tmux.conf;
    plugins = builtins.attrValues {
      inherit (pkgs.tmuxPlugins)
        vim-tmux-navigator
        catppuccin
        yank
        resurrect
        continuum
        ;
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (
        builtins.readFile (./config/oh-my-posh/omp-gruvbox-material.json # path relative to home.nix
        )
      )
    );
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "oliwia";
    userEmail = "24637207+kkanden@users.noreply.github.com";
    aliases = {
      lg = "log --oneline --graph --all --decorate --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(yellow)%h%Creset - %C(blue)%an <%ae>%Creset - %C(green)%ad%Creset -%C(red)%d%Creset %s'";
      lgu = "log --oneline --graph origin..HEAD";
    };
    extraConfig = {
      init.defaultbranch = "main";
      core = {
        editor = "nvim";
        autocrlf = false;
      };
      status = {
        branch = true;
        short = true;
        showStash = true;
      };
      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      url = {
        "https://github.com/" = {
          insteadOf = "gh:";
        };
      };
      colors = {
        diff = {
          meta = "black bold";
          frag = "magenta";
          context = "white";
          whitespace = "yellow reverse";
        };
      };
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

  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile ./config/fastfetch/config.jsonc)
    );
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
