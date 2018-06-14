# Improve directory management and `cd`


# Improve `cd`
setopt auto_pushd                   # Make `cd` behave like pushd
setopt pushd_minus                  # Make `cd -` behave like `pushd -` (rotate the stack)
setopt pushd_ignore_dups            # Ignore duplicates in pushd stack

alias d="dirs -v | head -10"        # Alias for displaying directory stack
alias pd="popd"

# Sortcuts for `ls`
if command -v "exa" >/dev/null 2>&1 ; then          # Use `exa` if available
    alias ll="exa -lhb"
    alias la="exa -lhba"
    alias ls="exa"
else                                                # Fallback to `ls`
    alias ll="ls -lhF --color=auto"
    alias la="ls -lAhF --color=auto"
    alias ls="ls -F --color=auto"
fi
