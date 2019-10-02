# ==== VCS support
autoload -Uz vcs_info

# enable VCS systems
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# Enable parameter expansion, command substitution, and arithmetic expansion
# in the prompt
setopt prompt_subst

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*' # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '+'   # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '[%b%|%a%c%u%]%f'
zstyle ':vcs_info:*' formats ':%b%c%u%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }

# ==== Colors
autoload -Uz colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# ==== Notifications
setopt nobeep # avoid beeping

# ==== Prompt
autoload -Uz promptinit && promptinit
PROMPT='[%{$fg[red]%}%n%{$fg[yellow]%}@%m%{$reset_color%} %c%{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}]%# '
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "
