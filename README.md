### Dotfiles

## Setup

# clone repository
git clone ...
git submodule init
git submodule update --depth 1

# setup vim
mkdir ~/.vimbackup
rm ~/.vimrc
ln -s .vimrc ~/.vimrc
rm -r ~./vim
ln -s .vim ~/.vim

# setup zsh
rm ~/.zshrc
ln -s .zshrc ~/.zshrc
mkdir -p ~/.zsh/cache
ln -s .zsh/lib ~/.zsh/lib

# setup ssh config
rm ~/.ssh/config
ln -s .ssh/config ~/.ssh/config

# setup tmux
rm ~/.tmux.conf
ln -s .tmux.conf ~/.tmux.conf
