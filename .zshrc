eval "$(starship init zsh)"

source ~/.config/zsh/mlx-helpers.sh

switch-nix() {
    sudo darwin-rebuild switch --flake $HOME/dots/nix
}


# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#F2DDBC,fg+:#C69478,bg:-1,bg+:-1
  --color=hl:#A74D39,hl+:#DF674C,info:#8A4B53,marker:#616655
  --color=prompt:#DF674C,spinner:#F2A766,pointer:#C69478,header:#8A4B53
  --color=border:#F2DDBC,label:#F2DDBC,query:#F2DDBC
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" "
  --marker="->" --pointer="*" --separator="─" --scrollbar="│"
  --info="right"'
