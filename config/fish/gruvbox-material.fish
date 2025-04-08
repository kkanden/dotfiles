#!/usr/bin/fish

# Gruvbox Material Mix Soft Fish shell theme
set -l foreground E2CCA9 normal
set -l selection 5A524C brcyan
set -l comment 7C6F64 brblack
set -l red F2594B red
set -l orange F28534 brred
set -l yellow E9B143 yellow
set -l green 8BBA7F green
set -l cyan 80AA9E cyan
set -l pink D3869B brmagenta

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
