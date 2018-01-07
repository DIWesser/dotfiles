#!/bin/bash

# Mac
if [[ $(uname -s) == Darwin ]] ; then
    # Remove any existing dotfile
    rm ~/.bash_profile
    rm ~/.vimrc

    # Link new dotfiles
    ln -s .bashrc ~/.bash_profile
    # .vimrc location dependent on Neovim
    if [[ $(command -v nvim) ]] ; then
        ln .vimrc ~/.config/nvim/init.vim
    else
        ln -s .vimrc ~/.vimrc
    fi

# Linux
elif [[ $(uname -s) == Linux ]] ; then
    rm ~/.bashrc
    if [[ $(command -v nvim) ]] ; then
        ln .vimrc ~/.config/nvim/init.vim
    else
        ln -s .vimrc ~/.vimrc
    fi
fi
