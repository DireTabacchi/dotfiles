# /==================================================================\
# bashrc
# Author: Nathaniel Tabacchi
# Last Change: 2023 01 24
#
# \==================================================================/
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vim='nvim'
alias grep='grep --color'
alias hx='helix'
alias ls='ls --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias doomrl='cd ~/games/DoomRL/doomrl-linux-x64-0997-lq/'

PS1='\[\e[0m\][\[\e[0;34m\]\W\[\e[0m\]]\[\e[0;33m\] --,^^,*>\[\e[0m\] '

. "$HOME/.cargo/env"

[ -f "/home/nate/.ghcup/env" ] && source "/home/nate/.ghcup/env" # ghcup-env

## COLORSCRIPT ##
colorscript random

