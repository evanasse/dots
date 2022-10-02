all: alacritty leftwm nvim rofi tmux X

alacritty:
	mkdir -p ~/.config
	ln -s ~/git/dots/alacritty ~/.config/alacritty

leftwm:
	mkdir -p ~/.config
	ln -s ~/git/dots/leftwm ~/.config/leftwm
	ln -s ~/git/dots/leftwm/themes/nord ~/.config/leftwm/themes/current

nvim:
	mkdir -p ~/.config
	ln -s ~/git/dots/nvim ~/.config/nvim

rofi:
	mkdir -p ~/.config
	ln -s ~/git/dots/rofi ~/.config/rofi

tmux:
	ln -s ~/git/dots/tmux/.tmux.conf ~/.tmux.conf

X:
	ln -s ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -s ~/git/dots/X/.Xresources ~/.Xresources
