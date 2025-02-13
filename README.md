# Dotfiles
This repository hold my dotfiles which are wholly managed by [nix-community's Home Manager](https://github.com/nix-community/home-manager).

By running the flake, the programs will be installed and their config files put in their appropriate locations.

Two config files, for oh-my-posh and fastfetch, are stored separately and read in by Home Manager. 
This means that, e.g., to change the prompt style, you must edit the file at `.config/.my-omp-omp.json` and then run `home-manager switch --flake .` inside the repo, for the effect to take place.

Other programs that have user-facing configuration available are configured in `home.nix`, except for neovim. for which you can find the configuration [here](https://github.com/kkanden/nvim).

## Repo location
It is recommended to store the repo directory outside of your `~/.config/`, e.g. in `~/dotfiles/`, directory to prevent any interference from happening.

However, since `home.nix` is then not stored in `~/.config/home-manager/` (where Home Manager looks by default), Home Manager will complain if you run plain `home-manager switch/build` as it can't find the `home.nix` file. 
Instead, on your first run, `cd` into the repo root and run `home-manager switch --flake .` to make Home Manager run from the flake. 
After restarting your shell session, the fish function `home` will do that for you.
