# ZSH Theme.

# Load color variables.
autoload -U colors && colors

# Enable advanced prompt substitutions.
setopt prompt_subst

# Basic prompt line.
PS1='[%n@%m %{$bold_color%}%1~%{$reset_color%}]%(!.#.$) '
RPS1='%(?..%{$fg_no_bold[red]%}[%{$fg_bold[red]%}%?%{$fg_no_bold[red]%}]%{$reset_color%})'
