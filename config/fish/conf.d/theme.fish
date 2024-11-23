# Cozy colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg ebdbb2
set -l sel 32302f

# --> palette
set -l red ec6f6f
set -l green b9bb4a
set -l yellow fabd2f
set -l orange f5a346
set -l blue 7ba0c3
set -l purple af86d3
set -l magenta d3869b
set -l cyan 7bc398
set -l black 665c54

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
    