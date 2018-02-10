# Environment variables to be set when the user logs in.


# Load utility functions (path_append, flags_append, ...)
source "${XDG_CONFIG_HOME:-$HOME/.config}/env/utils.sh"


# Set `EDITOR` and `VISUAL`
if command -v "nvim" >/dev/null 2>&1 ; then         # Use `nvim` if available
    nvim="$(command -v nvim)"

    export VISUAL="$nvim"
    export EDITOR="$nvim"

    unset nvim

elif command -v "vim" >/dev/null 2>&1 ; then        # Fallback 1: `vim`
    vim="$(command -v vim)"

    export VISUAL="$vim"
    export EDITOR="$vim"

    unset vim

elif command -v "vi" >/dev/null 2>&1 ; then         # Fallback 2: `vi`
    vi="$(command -v vi)"

    export VISUAL="$vi"
    export EDITOR="$vi"

    unset vi
fi


# Modify PATH etc., 

path_append PATH "${HOME}/.cargo/bin"


# Add compiler flags for native architecture optimizations

flags_append CFLAGS "-pipe" "-march=native"
flags_append CXXFLAGS "-pipe" "-march=native"

flags_append RUSTFLAGS "-C" "target-cpu=native"
