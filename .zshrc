eval "$(starship init zsh)"

sync-nix-config () {
    cp ~/.config/nix/flake.nix  ~/.config/nix-darwin/flake.nix
}

switch-nix () {
    sync-nix-config && \
        nix flake update --flake ~/.config/nix-darwin && \
        darwin-rebuild switch --flake ~/.config/nix-darwin#etiole
}
