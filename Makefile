all: alacritty leftwm nvim rofi tmux X

alacritty:
	ln -s ~/git/dots/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

leftwm:
	ln -s ~/git/dots/leftwm ~/.config/leftwm
	ln -s ~/git/dots/leftwm/themes/nord ~/.config/leftwm/themes/current

nvim:
	ln -s ~/git/dots/nvim ~/.config/nvim

rofi:
	ln -s ~/git/dots/rofi ~/.config/rofi

tmux:
	ln -s ~/git/dots/tmux/.tmux.conf ~/.tmux.conf

X:
	ln -s ~/git/dots/X/.xinitrc ~/.xinitrc
