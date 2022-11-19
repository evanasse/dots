is_4k=$$(xrandr | grep "current 3840")

farout: alacritty-farout leftwm-farout eww-farout nushell-farout nvim-farout rofi-farout tmux X-farout starship eww-reload
nord: alacritty-nord leftwm-nord eww-nord nushell-nord nvim-nord rofi-nord tmux X-nord starship eww-reload

alacritty-farout:
	mkdir -p ~/.config/alacritty
	ln -snf ~/git/dots/alacritty/* --target-directory ~/.config/alacritty
	sed -i -r --follow-symlink 's/(colors:).*/\1 *farout/' ~/.config/alacritty/alacritty.yml
	@if [[ $(is_4k) ]]; then\
		sed -i -r --follow-symlink 's/(size:).*/\1 *size_4k/' ~/.config/alacritty/alacritty.yml;\
	else\
		sed -i -r --follow-symlink 's/(size:).*/\1 *size_regular/' ~/.config/alacritty/alacritty.yml;\
	fi
alacritty-nord:
	mkdir -p ~/.config/alacritty
	ln -snf ~/git/dots/alacritty/* --target-directory ~/.config/alacritty
	sed -i -r --follow-symlink 's/(colors:).*/\1 *nord/' ~/.config/alacritty/alacritty.yml
	@if [[ $(is_4k) ]]; then\
		sed -i -r --follow-symlink 's/(size:).*/\1 *size_4k/' ~/.config/alacritty/alacritty.yml;\
	else\
		sed -i -r --follow-symlink 's/(size:).*/\1 *size_regular/' ~/.config/alacritty/alacritty.yml;\
	fi

eww-farout:
	mkdir -p ~/.config
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/farout/eww-bar ~/.config/eww;\
	else\
		ln -snf ~/git/dots/leftwm/themes/farout/eww-bar ~/.config/eww;\
	fi
eww-nord:
	mkdir -p ~/.config
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/nord/eww-bar ~/.config/eww;\
	else\
		ln -snf ~/git/dots/leftwm/themes/nord/eww-bar ~/.config/eww;\
	fi
eww-reload:
	# Do it a few times because sometimes it fails
	nu -c "ps | where name =~ eww | get pid | each { |it| kill \$$it }" || true
	nu -c "ps | where name =~ eww | get pid | each { |it| kill \$$it }" || true
	nu -c "ps | where name =~ eww | get pid | each { |it| kill \$$it }" || true
	eww daemon
	eww open bar0

leftwm-farout:
	mkdir -p ~/.config/leftwm
	ln -snf ~/git/dots/leftwm/* --target-directory ~/.config/leftwm
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/farout ~/.config/leftwm/themes/current;\
	else\
		ln -snf ~/git/dots/leftwm/themes/farout ~/.config/leftwm/themes/current;\
	fi
	leftwm-command SoftReload
leftwm-nord:
	mkdir -p ~/.config/leftwm
	ln -snf ~/git/dots/leftwm ~/.config/leftwm
	@if [[ $(is_4k) ]]; then\
		ln -snf ~/git/dots/leftwm/themes/4k/nord ~/.config/leftwm/themes/current;\
	else\
		ln -snf ~/git/dots/leftwm/themes/nord ~/.config/leftwm/themes/current;\
	fi
	leftwm-command SoftReload

nushell-farout:
	mkdir -p ~/.config
	ln -snf ~/git/dots/nushell/env.nu ~/.config/nushell/env.nu
	ln -snf ~/git/dots/nushell/config.nu ~/.config/nushell/config.nu
	ln -snf ~/git/dots/nushell/.dir_colors_farout ~/.config/nushell/.dir_colors
nushell-nord:
	mkdir -p ~/.config
	ln -snf ~/git/dots/nushell/env.nu ~/.config/nushell/env.nu
	ln -snf ~/git/dots/nushell/config.nu ~/.config/nushell/config.nu
	ln -snf ~/git/dots/nushell/.dir_colors_nord ~/.config/nushell/.dir_colors

nvim-farout:
	mkdir -p ~/.config/nvim
	ln -snf ~/git/dots/nvim/* --target-directory ~/.config/nvim
	sed -i -r --follow-symlink 's/(require\("appearance.).*/\1farout"\)/' ~/.config/nvim/after/plugin/appearance/colorscheme.lua
nvim-nord:
	mkdir -p ~/.config/nvim
	ln -snf ~/git/dots/nvim/* --target-directory ~/.config/nvim
	sed -i -r --follow-symlink 's/(require\("appearance.).*/\1nord"\)/' ~/.config/nvim/after/plugin/appearance/colorscheme.lua

rofi-farout:
	mkdir -p ~/.config/rofi
	ln -snf ~/git/dots/rofi/* --target-directory ~/.config/rofi/
	sed -i -r --follow-symlink 's/(@theme).*/\1 "farout"/' ~/.config/rofi/config.rasi
rofi-nord:
	mkdir -p ~/.config
	ln -snf ~/git/dots/rofi/* --target-directory ~/.config/rofi/
	sed -i -r --follow-symlink 's/(@theme).*/\1 "nord"/' ~/.config/rofi/config.rasi

starship:
	mkdir -p ~/.config
	ln -snf ~/git/dots/starship/starship.toml ~/.config/starship.toml

tmux:
	ln -snf ~/git/dots/tmux/.tmux.conf ~/.tmux.conf

X-farout:
	ln -snf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -snf ~/git/dots/X/farout-Xresources ~/.Xresources
X-nord:
	ln -snf ~/git/dots/X/.xinitrc ~/.xinitrc
	ln -snf ~/git/dots/X/nord-Xresources ~/.Xresources
