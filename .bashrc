#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$PATH:/mnt/c/Users/oliwia/scoop/neovim/bin/win32yank.exe"
exec fish

. "$HOME/.local/bin/env"
