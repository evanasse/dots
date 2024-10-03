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

# PATH
export PATH=$PATH:'~/sys-git/eww/target/release/'
export PATH=$PATH:'~/.cargo/bin/'
export PATH=$PATH:'~/.local/bin/'

export EDITOR="nvim --clean"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/etiole/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/etiole/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

export HISTCONTROL=ignoredups

# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#E0CCAE,fg+:#C69478,bg:-1,bg+:-1
  --color=hl:#A74D39,hl+:#DF674C,info:#8A4B53,marker:#616655
  --color=prompt:#DF674C,spinner:#F2A766,pointer:#AA6B73,header:#8A4B53
  --color=border:#F2DDBC,label:#F2DDBC,query:#E0CCAE
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" "
  --marker="->" --pointer="*" --separator="─" --scrollbar="│"
  --info="right"'
