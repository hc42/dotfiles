# ==== Directories

# If you type foo, and it isn't a command, and it is a directory in your
# cdpath, go there
setopt auto_cd

# push dirs to stack on cd
setopt auto_pushd

# don't push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups
