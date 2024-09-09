#! /bin/bash



###  NEOVIM
file=nvim
Target=$HOME/.config/$file
if [ -e $Target ];then
    rm -rf $Target    
fi
ln -s $(pwd)/$file $Target


### Hyprland
file=hypr
Target=$HOME/.config/$file
if [ -e $Target ];then
    rm -rf $Target    
fi
ln -s $(pwd)/$file $Target


# kitty
file=kitty
Target=$HOME/.config/$file
if [ -e $Target ];then
    rm -rf $Target    
fi
ln -s $(pwd)/$file $Target


### starship

file=starship.toml
Target=$HOME/.config/$file
if [ -e $Target ];then
    rm -rf $Target    
fi
ln -s $(pwd)/$file $Target

