all: alacritty leftwm nvim rofi tmux X

alacritty:
	mkdir -p ~/.config
	ln -sf ~/git/dots/alacritty ~/.config/alacritty

leftwm:
	mkdir -p ~/.config
	ln -sf ~/git/dots/leftwm ~/.config/leftwm
	ln -sf ~/git/dots/leftwm/themes/nord ~/.config/leftwm/themes/current

nushell:
	mkdir -p ~/.config
	ln -sf ~/git/dots/nushell ~/.config/nushell
nvim:
	mkdir -p ~/.config
	ln -sf ~/git/dots/nvim ~/.config/nvim

rofi:
	mkdir -p ~/.config
	ln -sf ~/git/dots/rofi ~/.config/rofi

starship:
	mkdir -p ~/.config
	ln -sf ~/git/dots/starship/starship.toml ~/.config/starship.toml

tmux:
	ln -sf ~/git/dots/tmux/.tmux.conf ~/.tmux.conf

X:
	ln -sf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -sf ~/git/dots/X/.Xresources ~/.Xresources
