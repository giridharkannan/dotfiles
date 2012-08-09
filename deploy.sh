#!/bin/bash

echo "This script deletes some files, so you might want to read the source first. Go on, I'll wait."
echo "Then, press any key when you're ready"
read i;
 
echo "Deleting old files..."
rm ~/.zshrc
rm ~/.vimrc
rm ~/.hgrc
rm ~/.hgignore
rm ~/.vim -r
rm ~/hg -r
rm ~/oh-my-zsh -r
rm ~/.emacs.d -rf
rm ~/.tmux.conf
rm ~/.Xdefaults

rm ~/.xmonad -r
rm ~/.xmobarrc

echo "Symlinking files..."
ln -s `pwd`/oh-my-zsh/ ~/
ln -s `pwd`/.zshrc ~/
ln -s `pwd`/.emacs.d/ ~/
ln -s `pwd`/.vim/ ~/
ln -s `pwd`/.vimrc ~/
ln -s `pwd`/hg/ ~/
ln -s `pwd`/.hgrc ~/
ln -s `pwd`/.hgignore ~/
ln -s `pwd`/tmux.conf ~/.tmux.conf
ln -s `pwd`/.Xdefaults ~/.Xdefaults

ln -s `pwd`/xmonad-config/.xmonad ~/
ln -s `pwd`/xmonad-config/.xmobarrc ~/.xmobarrc
