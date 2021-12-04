#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Name infront of command line prompt
export PS1="\[\033[38;5;202m\][\[$(tput sgr0)\]\[\033[38;5;214m\]\u\[$(tput sgr0)\]\[\033[38;5;106m\]@\[$(tput sgr0)\]\[\033[38;5;73m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;212m\]\W\[$(tput sgr0)\]\[\033[38;5;202m\]]\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

# Default programs
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim

# Aliases
alias ls='ls -F --color=auto'
alias la='ls -a -F --color=auto'
alias ll='ls -a -l -F --color=auto'
alias vi='nvim'
alias vim='nvim'
alias mutt='neomutt'
alias mail='neomutt'
alias vol='alsamixer'
alias mm='make && ./main'
alias canvas='(firefox --new-window "https://njit.instructure.com/?login_success=1" & disown) > /dev/null 2>&1'

alias lisp='sbcl'
alias prolog='swi-prolog'

. "$HOME/.cargo/env"

[[ -f "$HOME/sshkeys" ]] && source "$HOME/sshkeys"
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash

alias todo=~/tests/rusttest/a/target/debug/a

# $1 number to convert
# $2 base to convert to (default 2)
# $3 pad front until total length is `width`
function base() {
    [[ -z $1 ]] && { echo "usage: base number [base [width]]"; return; }
    local num=$1
    local to=${2:-2}
    local width=${3:-0}
    node -p "let x=Number($num).toString($to);let s='';if($width -x.length>0)[...Array($width -x.length)].forEach(()=>s+='0');s+x;"
}

export FZF_DEFAULT_COMMAND="find -L"
