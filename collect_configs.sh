#/bin/bash
DIR=~/develop/dotfiles/
CFG=~/.config/
cp -rv ${CFG}i3 $DIR
cp -rv ${CFG}moc $DIR
cp -rv ${CFG}polybar $DIR
cp -rv ${CFG}vifm $DIR
cp -v ~/.Xresources $DIR
cp -v ~/.vimrc $DIR
cp -v ~/.bashrc $DIR
