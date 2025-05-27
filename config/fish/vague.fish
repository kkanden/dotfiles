#!/usr/bin/fish

set -l foreground CDCDCD normal
set -l selection BEBEDA brcyan
set -l comment 606079 brblack
set -l red D8647e red
set -l orange E08398 brred
set -l yellow F3BE7C yellow
set -l green 7FA563 green
set -l purple BB9DBD magenta
set -l cyan AEAED1 cyan
set -l pink C9B1CA brmagenta

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
