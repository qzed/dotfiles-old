# ZSH key bindings.

zmodload zsh/terminfo
zmodload zsh/zle

bindkey -e


# Key-codes from `terminfo` are only valid when the terminal is in application-mode.
# Ensures that this is the case when zle reads an input line.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle-line-init () {
        echoti smkx
    }

    zle-line-finish () {
        echoti rmkx
    }

    zle -N zle-line-init
    zle -N zle-line-finish
fi


# Load key codes from terminfo.
typeset -A key

# Set basic key codes.
key[BackSpace]="$terminfo[kbs]"
key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# Set extended key codes, may not be present on all terminals.
# Use `infocmp -x` to list the ones available for the current terminal.
key[C-Home]="$terminfo[kHOM5]"
key[C-End]="$terminfo[kEND5]"
key[C-Delete]="$terminfo[kDC5]"
key[C-Up]="$terminfo[kUP5]"
key[C-Down]="$terminfo[kDN5]"
key[C-Left]="$terminfo[kLFT5]"
key[C-Right]="$terminfo[kRIT5]"

key[M-Home]="$terminfo[kHOM3]"
key[M-End]="$terminfo[kEND3]"
key[M-Delete]="$terminfo[kDC3]"
key[M-Up]="$terminfo[kUP3]"
key[M-Down]="$terminfo[kDN3]"
key[M-Left]="$terminfo[kLFT3]"
key[M-Right]="$terminfo[kRIT3]"

key[M-BackSpace]="^[^?"
key[Tab]="^I?"


# Bind function ($2) to key code ($1) if the key code is not empty.
try_bindkey () {
    [[ -n "$1" ]] && bindkey -- "$1" $2
}

# Set key bindings.
try_bindkey "$key[Home]"        beginning-of-line
try_bindkey "$key[End]"         end-of-line
try_bindkey "$key[Insert]"      overwrite-mode
try_bindkey "$key[Backspace]"   backward-delete-char
try_bindkey "$key[Delete]"      delete-char
try_bindkey "$key[Up]"          history-beginning-search-backward-end
try_bindkey "$key[Down]"        history-beginning-search-forward-end
try_bindkey "$key[Left]"        backward-char
try_bindkey "$key[Right]"       forward-char

try_bindkey "$key[PageUp]"      beginning-of-history
try_bindkey "$key[PageDown]"    end-of-history

try_bindkey "$key[C-Up]"        up-line-or-history
try_bindkey "$key[C-Down]"      down-line-or-history
try_bindkey "$key[C-Left]"      vi-backward-word
try_bindkey "$key[C-Right]"     vi-forward-word
try_bindkey "$key[C-Delete]"    vi-kill-word

try_bindkey "$key[M-BackSpace]" vi-backward-kill-word

try_bindkey "^d"                vi-kill-word
try_bindkey "^k"                history-beginning-search-backward-end
try_bindkey "^j"                history-beginning-search-forward-end
try_bindkey "^h"                backward-char
try_bindkey "^l"                forward-char
try_bindkey "^b"                vi-backward-word
try_bindkey "^w"                vi-forward-word
try_bindkey "^e"                vi-forward-word-end
try_bindkey "^u"                vi-kill-line
try_bindkey "^f"                vi-kill-eol

try_bindkey "^[b"               backward-word
try_bindkey "^[w"               forward-word


# Load history backward/forward search functions.
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end


# VI-like word handling for input.
vi-kill-word () {
    local WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
    zle kill-word
}

zle -N vi-kill-word
