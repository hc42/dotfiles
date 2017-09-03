# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
export GOPATH=~/go
#export EDITOR="vim"
fpath=(/usr/local/share/zsh-completions $fpath)

# ==== no atuocorrect Aliases
alias vim='nocorrect vim'
alias mv='nocorrect mv'
alias grunt='nocorrect grunt'
alias ssh='nocorrect ssh'
alias git='nocorrect git'

# ==== Global Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# ==== Alias Commands
alias ll="ls -alh"

# ==== Commands By File Extension
alias -s php=vim
alias -s js=vim
alias -s html=vim
alias -s conf=vim
alias -s h=vim
alias -s c=vim
alias -s java=vim
alias -s txt=vim

# ==== Notifications
setopt nobeep # avoid beeping

# ==== Directories
setopt auto_cd # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt auto_pushd # push dirs to stack on cd
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack

# ===== Expansion and Globbing
setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation

# ==== Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# ==== Completion
setopt complete_in_word # stays where it is and completion is done from both ends
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word

zstyle ':completion:*' use-cache on # for slow completions
zstyle ':completion:*' cache-path ~/.zsh/cache # set cache dir
zstyle ':completion:*' menu select=5 # complete menu on 5 or more entries
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
 'm:{a-z\-}={A-Z\_}' \
 'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

# === URL Quotation
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic # automatically quote urls

autoload -U compinit && compinit -i

# ==== Prompt
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -Uz vcs_info

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true

setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt

# Look at http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# for mor options
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '[%b%|%a%c%u%]%f'
zstyle ':vcs_info:*' formats ':%b%c%u%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

PROMPT='[%{$fg[red]%}%n%{$fg[yellow]%}@%m%{$reset_color%} %c%{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}]%# '
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "

# ==== LS Colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# ssh host completion by known_hosts file
local hosts
if [ -e $HOME/.ssh/known_hosts ] ; then
  hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
fi
if [ -e $HOME/.ssh/config ] ; then
  hosts=($hosts ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
zstyle ':completion:*:hosts' hosts $hosts

if [ -f ~/.zshrc.local ] ; then ; source ~/.zshrc.local; fi
