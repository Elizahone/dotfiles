#!/bin/sh


set_prompt() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
	PS1="\[\e[38;5;220m\]╭─\[\e[38;5;220m\]\[\e[38;5;34m\]\u\[\e[38;5;40m\]@\[\e[38;5;46m\]\h [\[\e[38;5;154m\]\w] \[\033[0m\]\n\[\e[38;5;154m\]╰λ\[\033[0m\] "
}

PROMPT_COMMAND=set_prompt
