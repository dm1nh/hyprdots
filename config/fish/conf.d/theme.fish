# Cozy colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg d5d6c8
set -l sel 232b2e

# --> palette
set -l red e67e80
set -l green b2c98f
set -l yellow dbbc7f
set -l orange e69875
set -l blue 82a5d7
set -l purple b795db
set -l magenta e3a8d1
set -l cyan 93c9a1
set -l black 636869

# Syntax Highlighting
set -g fish_color_normal $fg
set -g fish_color_command $green
set -g fish_color_param $fg
set -g fish_color_keyword $red
set -g fish_color_quote $green
set -g fish_color_redirection $purple
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_gray $black
set -g fish_color_selection --background=$sel
set -g fish_color_search_match --background=$sel
set -g fish_color_operator $blue
set -g fish_color_escape $purple
set -g fish_color_autosuggestion $black
set -g fish_color_cancel $red

# Prompt
set -g fish_color_cwd $yellow
set -g fish_color_user $cyan
set -g fish_color_host $blue

# Completion Pager
set -g fish_pager_color_progress $black
set -g fish_pager_color_prefix $purple
set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $black
    