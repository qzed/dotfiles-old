# Improve directory management and `cd`


# Improve `cd`
setopt auto_pushd                   # Make `cd` behave like pushd
setopt pushd_minus                  # Make `cd -` behave like `pushd -` (rotate the stack)
setopt pushd_ignore_dups            # Ignore duplicates in pushd stack

alias d="dirs -v | head -10"        # Alias for displaying directory stack
alias pd="popd"

# Sortcuts for `ls`
if command -v "exa" >/dev/null 2>&1 ; then          # Use `exa` if available
    alias ll="exa -lhb --group-directories-first"
    alias la="exa -lhba --group-directories-first"
    alias ls="exa --group-directories-first"
    alias t="exa -T --group-directories-first"
else                                                # Fallback to `ls`
    alias ll="ls -lhF --color=auto"
    alias la="ls -lAhF --color=auto"
    alias ls="ls -F --color=auto"
    alias t="tree"
fi
