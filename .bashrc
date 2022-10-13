#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
parse_git_modified() {
    [[ -z $(git status -s 2> /dev/null) ]] || echo " + "
}
# Name infront of command line prompt
export PS1=""
PS1+="\[\033[38;5;202m\][\[$(tput sgr0)\]"      # [
PS1+="\[\033[38;5;214m\]\u\[$(tput sgr0)\]"     # chris
PS1+="\[\033[38;5;106m\]@\[$(tput sgr0)\]"      # @
PS1+="\[\033[38;5;73m\]\h\[$(tput sgr0)\]"      # host
PS1+=" \[$(tput sgr0)\]"                        # space
PS1+="\[\033[38;5;212m\]\W\[$(tput sgr0)\]"     # short dir
PS1+="\[\033[38;5;2m\]\$(parse_git_branch)"     # space(branch)
PS1+="\[\033[38;5;11m\]\$(parse_git_modified)"  # modified
PS1+="\[\033[38;5;202m\]]\[$(tput sgr0)\]"      # ]
PS1+="\$ \[$(tput sgr0)\]"                      # $space

# Default programs
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim

# Aliases
alias ls='ls -F --color=auto'
alias la='ls -a -F --color=auto'
alias ll='ls -a -l -F --color=auto'
# alias vi='nvim'
# alias vim='nvim'
alias vi='vim'
alias vol='alsamixer'
alias canvas='(firefox --new-window "https://njit.instructure.com/?login_success=1" & disown) > /dev/null 2>&1'

[[ -f ~/servers ]] && source ~/servers
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash

# to use for getting branch name in PS1
# git branch | grep '^\*' | sed 's/^\*\s//g'

# Git aliases
# alias gitlog="git log --all --decorate --oneline --graph"
alias gitlog="lg1"
alias gs="git status"

export FZF_DEFAULT_COMMAND="find -L"

# FZF through history and run the command
function fzfhist() {
    eval $(history | cut -c 8- | fzf)
}

# FZF through branches and checkout
function gitcheckout {
    git checkout $(git branch | fzf)
}
function lg1 {
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
}
function lg2 {
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
}

# Cargo
. "$HOME/.cargo/env"

# 3DS Dev
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPRO=/opt/devkitpro
