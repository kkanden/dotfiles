set -g __fish_config_start (date +%s%N)

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# disable greeting
function fish_greeting
end

# OH-MY-POSH
oh-my-posh init fish --config '~/.config/.my-omp.omp.json' | source

# fish_vi_key_bindings

# ALIASES

set -g __fish_config_end (date +%s%N)
set -g __fish_config_duration (math "($__fish_config_end - $__fish_config_start) / 1000000")
set -g __fish_config_duration (printf "%.3f" $__fish_config_duration)
echo "took $__fish_config_duration ms" | cowsay | lolcat

