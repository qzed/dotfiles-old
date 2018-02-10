# User profile for zsh.

# Load user-specific environment variables, emulate sh
emulate sh -c "source \"${XDG_CONFIG_HOME:-$HOME/.config}/env/user.sh\""
