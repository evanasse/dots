farout: alacritty-farout eww-farout leftwm-farout nushell-farout nvim-farout rofi-farout tmux X-farout
nord: alacritty-nord eww-nord leftwm-nord nushell-nord nvim-nord rofi-nord tmux X-nord

alacritty-farout:
	mkdir -p ~/.config/alacritty
	ln -sf ~/git/dots/alacritty/* --target-directory ~/.config/alacritty
	sed -i -r --follow-symlink 's/(colors:).*/\1 *farout/' ~/.config/alacritty/alacritty.yml
alacritty-nord:
	mkdir -p ~/.config/alacritty
	ln -sf ~/git/dots/alacritty/* --target-directory ~/.config/alacritty
	sed -i -r --follow-symlink 's/(colors:).*/\1 *nord/' ~/.config/alacritty/alacritty.yml

eww-farout:
	mkdir -p ~/.config
	ln -sf ~/git/dots/leftwm/themes/farout/eww-bar ~/.config/eww
eww-nord:
	mkdir -p ~/.config
	ln -sf ~/git/dots/leftwm/themes/nord/eww-bar ~/.config/eww

leftwm-farout:
	mkdir -p ~/.config/leftwm
	ln -sf ~/git/dots/leftwm/* --target-directory ~/.config/leftwm
	ln -sf ~/git/dots/leftwm/themes/farout ~/.config/leftwm/themes/current
leftwm-nord:
	mkdir -p ~/.config
	ln -sf ~/git/dots/leftwm ~/.config/leftwm
	ln -sf ~/git/dots/leftwm/themes/nord ~/.config/leftwm/themes/current

nushell-farout:
	mkdir -p ~/.config
	ln -sf ~/git/dots/nushell/env.nu ~/.config/nushell/env.nu
	ln -sf ~/git/dots/nushell/config.nu ~/.config/nushell/config.nu
	ln -sf ~/git/dots/nushell/.dir_colors_farout ~/.config/nushell/.dir_colors
nushell-nord:
	mkdir -p ~/.config
	ln -sf ~/git/dots/nushell/env.nu ~/.config/nushell/env.nu
	ln -sf ~/git/dots/nushell/config.nu ~/.config/nushell/config.nu
	ln -sf ~/git/dots/nushell/.dir_colors_nord ~/.config/nushell/.dir_colors

nvim-farout:
	mkdir -p ~/.config/nvim
	ln -sf ~/git/dots/nvim/* --target-directory ~/.config/nvim
	sed -i -r --follow-symlink 's/(require("appearance.).*/\1farout")/' ~/.config/nvim/after/plugin/appearance/colorscheme.lua
nvim-nord:
	mkdir -p ~/.config/nvim
	ln -sf ~/git/dots/nvim/* --target-directory ~/.config/nvim
	sed -i -r --follow-symlink 's/(require("appearance.).*/\nord")/' ~/.config/nvim/after/plugin/appearance/colorscheme.lua

rofi-farout:
	mkdir -p ~/.config/rofi
	ln -sf ~/git/dots/rofi/* --target-directory ~/.config/rofi/
	sed -i -r --follow-symlink 's/(@theme).*/\1 "farout"/' ~/.config/rofi/config.rasi
rofi-nord:
	mkdir -p ~/.config
	ln -sf ~/git/dots/rofi/* --target-directory ~/.config/rofi/
	sed -i -r --follow-symlink 's/(@theme).*/\1 "nord"/' ~/.config/rofi/config.rasi

starship:
	mkdir -p ~/.config
	ln -sf ~/git/dots/starship/starship.toml ~/.config/starship.toml

tmux:
	ln -sf ~/git/dots/tmux/.tmux.conf ~/.tmux.conf

X-farout:
	ln -sf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -sf ~/git/dots/X/farout-Xresources ~/.Xresources
X-nord:
	ln -sf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -sf ~/git/dots/X/nord-Xresources ~/.Xresources
