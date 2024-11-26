#!/bin/bash
dotfiles=(hypr kitty starship.toml tofi waybar yazi mako zed)
DT_DIR=$HOME/dotfiles
for dt in "${dotfiles[@]}"; do
	target=$HOME/.config/$dt
	if [ -e $target ]; then
		rm -rf $target
	fi
	ln -s $DT_DIR/$dt $target
done
