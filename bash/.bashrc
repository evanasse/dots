#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim=nvim
alias dots='cd ~/git/dots'

# Prompt
eval "$(starship init bash)"

# Completions
source ~/.config/bash/completions/git-completions.sh
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Functions

function pde {
    env_vars=""
    if [[ -f "pyproject.toml" ]]; then
        env_vars="VIRTUAL_ENV=.venv"
    fi
    wezterm cli split-pane --right --percent 64 --cwd $(pwd) -- bash -c "$env_vars nvim"
}

# PATH
export PATH=$PATH:'~/sys-git/eww/target/release/'
export PATH=$PATH:'~/.cargo/bin/'
export PATH=$PATH:'~/.local/bin/'
export PATH=$PATH:'~/miniconda3/bin/'

export EDITOR="nvim"
