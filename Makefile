is_4k=$$(xrandr | grep "current 3840")

.PHONY: all git leftwm eww desktop bash nvim rofi starship wezterm X

farout: THEME = farout
farout: all

all: git bash nvim rofi X starship desktop

git:
	ln -snf ~/git/dots/git/.gitconfig ~/.gitconfig

leftwm:
	mkdir -p ~/.config/leftwm
	ln -snf ~/git/dots/leftwm/* --target-directory ~/.config/leftwm
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/$(THEME) ~/.config/leftwm/themes/current;\
	else\
		ln -snf ~/git/dots/leftwm/themes/$(THEME) ~/.config/leftwm/themes/current;\
	fi
	leftwm-command SoftReload

eww: leftwm
	mkdir -p ~/.config
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/$(THEME)/eww-bar ~/.config/eww;\
	else\
		ln -snf ~/git/dots/leftwm/themes/$(THEME)/eww-bar ~/.config/eww;\
	fi
	pkill eww || true
	eww daemon
	eww open bar0

desktop: eww

bash:
	mkdir -p ~/.config/bash
	ln -sf ~/git/dots/bash/.bashrc ~/.bashrc
	ln -sf ~/git/dots/bash/completions --target-directory ~/.config/bash

nvim:
	mkdir -p ~/.config/nvim
	ln -snf ~/git/dots/nvim/* --target-directory ~/.config/nvim

rofi:
	mkdir -p ~/.config/rofi
	ln -snf ~/git/dots/rofi/* --target-directory ~/.config/rofi/
	sed -i -r --follow-symlink 's/(@theme).*/\1 "$(THEME)"/' ~/.config/rofi/config.rasi
	@if [[ $(is_4k) ]]; then\
		sed -i -r --follow-symlink 's/(font: "UbuntuMono Nerd Font).*/\1 28";/' ~/.config/rofi/config.rasi;\
	else\
		sed -i -r --follow-symlink 's/(font: "UbuntuMono Nerd Font).*/\1 12";/' ~/.config/rofi/config.rasi;\
	fi

starship:
	mkdir -p ~/.config
	ln -snf ~/git/dots/starship/starship.toml ~/.config/starship.toml

wezterm:
	mkdir -p ~/.config/wezterm/
	ln -snf ~/git/dots/wezterm/* --target-directory ~/.config/wezterm

X:
	ln -snf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -snf ~/git/dots/X/$(THEME)-Xresources ~/.Xresources
