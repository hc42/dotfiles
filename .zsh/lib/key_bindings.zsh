# ==== Key bindings

# ==== History
# arrow up,down to use history search with cursor end
# http://www.opensource.apple.com/source/zsh/zsh-55/zsh/Functions/Zle/history-search-end
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# history seach backward on up key based upon what has already been entered at the prompt
bindkey "^[[A" history-beginning-search-backward-end
# history seach forward on down key based upon what has already been entered at the prompt
bindkey "^[[B" history-beginning-search-forward-end

# ctrl+r to search histroy backwards (export VISUAL disables this default)
bindkey '^r' history-incremental-search-backward

# ==== Movement, search and misc

# Make Fn + delete on OSX work
bindkey "^[[3~" delete-char

# Make shift + tab as reverse wokring
bindkey '^[[Z' reverse-menu-complete

# Make fn + up, down work on OSX
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Make alt + left or right move word forward or backwars
bindkey "^[f" forward-word
bindkey "^[b" backward-word

# ==== Command line interactive edit
autoload -Uz edit-command-line
zle -N edit-command-line
# Ctrl-x-e to edit command line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
