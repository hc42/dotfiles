# ==== Command history

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # Write to the history file immediately, not when the shell exits.
setopt share_history # share history between different instances of the shell
setopt hist_ignore_space # Do not record an entry starting with a space.
