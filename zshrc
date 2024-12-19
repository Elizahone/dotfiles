# Delete above before reinstall.
# zimfw  -> curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
# yazi
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function cd() {
	builtin cd $@;lsd
}


function e() {
  str=$@
  if [[ "$str" == .* ]]; then
    str="$PWD${str:1}"
  fi
  hyprctl dispatch exec "emacs --chdir $str" > /dev/null
}

export PATH=$PATH:$HOME/.local/share/nvim/mason/bin

alias ls="lsd -F"
alias ll="lsd -alF"
alias tree="lsd --tree --depth=3"

eval "$(starship init zsh)"
