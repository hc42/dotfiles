# load all sub config files
for config_file (~/.zsh/lib/*.zsh) source $config_file

# load local config
if [ -f ~/.zshrc.local ] ; then ; source ~/.zshrc.local; fi
