# ==== Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# ==== no atuocorrect Aliases
alias vim='nocorrect vim'
alias mv='nocorrect mv'
alias grunt='nocorrect grunt'
alias ssh='nocorrect ssh'
alias git='nocorrect git'

# ==== URL Quotation
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic # automatically quote urls
# As of zsh-5.1, the following may also be necessary in order to apply quoting to copy-pasted URLs:
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
