# ~/.config/shell/prompt.zsh
# zsh prompt built on Zim's prompt modules (prompt-pwd, git-info, duration-info).
# Recreates the two-line   ╭─ user@host [cwd] / ╰λ   style of the old bash prompt.

setopt PROMPT_CR PROMPT_SP PROMPT_SUBST

autoload -Uz add-zsh-hook

# --- duration-info: show how long the last command took (only if > threshold) ---
zstyle ':zim:duration-info' format ' %F{244}%d%f'
zstyle ':zim:duration-info' threshold 2
add-zsh-hook preexec duration-info-preexec
add-zsh-hook precmd duration-info-precmd

# --- git-info: show branch and working-tree status inside a repo ---
typeset -gA git_info
zstyle ':zim:git-info:branch' format '%b'
zstyle ':zim:git-info:unindexed' format '!'   # changes in working tree
zstyle ':zim:git-info:indexed' format '+'     # changes in index
zstyle ':zim:git-info:ahead' format '>'       # ahead of upstream
zstyle ':zim:git-info:behind' format '<'      # behind upstream
zstyle ':zim:git-info:stashed' format '$'     # stash present
zstyle ':zim:git-info:keys' format 'prompt' ' %%F{135}(%b%I%i%A%B%S)%%f'
add-zsh-hook precmd git-info

# --- the prompt itself ---
# %n user, %m short host, $(prompt-pwd) cwd with ~ collapsed
PS1=$'%F{220}╭─%F{34}%n%F{40}@%F{46}%m %F{154}[$(prompt-pwd)]%f${(e)git_info[prompt]}${duration_info}\n%F{154}╰λ%f '
RPS1=''
