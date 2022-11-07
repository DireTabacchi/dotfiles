#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

PS1='\[\e[0m\][\[\e[0;34m\]\W\[\e[0m\]]\[\e[0;36m\]\$\[\e[0m\]'
. "$HOME/.cargo/env"

[ -f "/home/nate/.ghcup/env" ] && source "/home/nate/.ghcup/env" # ghcup-env

## COLORSCRIPT ##
colorscript random

