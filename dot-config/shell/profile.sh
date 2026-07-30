#!/bin/sh

[ -d "$HOME/.local/bin" ] && PATH="${PATH}:$HOME/.local/bin"


# environment variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"


