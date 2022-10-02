all: alacritty leftwm nvim rofi tmux X

alacritty:
	ln -s alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

leftwm:
	ln -s leftwm ~/.config/leftwm
	ln -s leftwm/themes/nord ~/.config/leftwm/themes/current

nvim:
	ln -s nvim ~/.config/nvim

rofi:
	ln -s rofi ~/.config/rofi

tmux:
	ln -s tmux/.tmux.conf ~/.tmux.conf

X:
	ln -s X/.xinitrc ~/.xinitrc
