# ===== Expansion and Globbing
setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation

# ==== Completion rules
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

# ==== Host Completion

# ssh host completion by known_hosts file
local hosts
if [ -e $HOME/.ssh/known_hosts ] ; then
  if [ ! -f /etc/ssh/ssh_config ] || [ "$(grep HashKnownHosts /etc/ssh/ssh_config |grep yes)" = "" ] ; then
    hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
  fi
fi
if [ -e $HOME/.ssh/config ] ; then
  hosts=($hosts ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
zstyle ':completion:*:hosts' hosts $hosts
unset hosts

# ==== zsh-autosuggestions plugin
source ~/.zsh/lib/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==== Extended completion

# Extend Autocomplete Search Path

# if https://github.com/zsh-users/zsh-completions installed
# path for osx completions using homebrew
if [ -d /usr/local/share/zsh-completions ] ; then ; fpath=(/usr/local/share/zsh-completions $fpath) ; fi
# path for freebsd
if [ -d /usr/local/share/zsh/site-functions ] ; then ; fpath=(/usr/local/share/zsh/site-functions $fpath) ; fi
# path for linux
if [ -d /usr/share/zsh/vendor-completions ] ; then ; fpath=(/usr/share/zsh/vendor-completions $fpath) ; fi
# local scripts
if [ -d $HOME/.zsh-completions ] ; then ; fpath=($HOME/.zsh-completions $fpath) ; fi

# compinit - check dump file only once a day
autoload -Uz compinit
zstyle :compinstall filename '.zsh/lib/completion.zsh'
for dump in ~/.zcompdump.local(N.mh+24); do
  compinit -d ~/.zcompdump.local
done
compinit -C -d ~/.zcompdump.local
