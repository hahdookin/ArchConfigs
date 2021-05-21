#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Name infront of command line prompt
export PS1="\[\033[38;5;202m\][\[$(tput sgr0)\]\[\033[38;5;214m\]\u\[$(tput sgr0)\]\[\033[38;5;106m\]@\[$(tput sgr0)\]\[\033[38;5;73m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;212m\]\W\[$(tput sgr0)\]\[\033[38;5;202m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim

# Aliases
alias ls='ls -F --color=auto'
alias la='ls -a -F --color=auto'
alias vi="nvim"
alias vim="nvim"
alias mutt="neomutt"
alias mail="neomutt"
alias vol="alsamixer"
