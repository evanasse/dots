#!/bin/bash

set -e

echo "Starting points:"
echo "[0] Upgrade system packages"
# echo "[1] Create user"
# echo "[2] Install 'sudo'"
echo "[3] Make Git directories"
echo "[4] Install Rust"
echo "[5] Install desktop environment stuff"
echo "[6] Install terminal stuff"
echo "[7] Install various system packages"
echo "[8] Install Neovim"
# echo "[9] Install extra apps"
read -p "Select starting point [0]: " start_point
read -p "Select ending point [9]: " end_point

if [[ -z $start_point ]]; then
    start_point=0
fi
if [[ -z $end_point ]]; then
    end_point=8
fi


increment_start_point(){
    start_point=$start_point+1
}

as_user(){
    sudo --shell --set-home --user $username $@
}

installation_header(){
    echo ""
    echo "//// $1..."
    echo ""
}

# read -p "Enter target username: " username

#######################################
#
# UPGRADE SYSTEM PACKAGES
#
#######################################
if [[ $start_point -eq 0 && $start_point -le $end_point ]]; then
    installation_header "Upgrading system packages"

    as_user apt update
    as_user apt upgrade -y

    increment_start_point
fi

#######################################
#
# CREATE USER
#
#######################################
if [[ $start_point -eq 1 && $start_point -le $end_point ]]; then
    installation_header "Creating user"

    useradd -m -G users,wheel $username
    passwd $username

    # Roll back user creation in case of error
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "Error during user creation. Rolling back changes."
        userdel -r $username

        exit $exit_code
    fi

    echo "User '$username' created."

    increment_start_point
fi


#######################################
#
# INSTALL SUDO
#
#######################################
if [[ $start_point -eq 2 && $start_point -le $end_point ]]; then
    installation_header "Installing 'sudo'"

    pacman -Sy --noconfirm sudo

    sed -i "s/# %wheel ALL=(ALL:ALL) NOPASS/%wheel ALL=(ALL:ALL) NOPASS/" /etc/sudoers

    echo "'sudo' installed."

    increment_start_point
fi

#######################################
#
# MAKE GIT DIRECTORIES
#
#######################################
if [[ $start_point -eq 3 && $start_point -le $end_point ]]; then
    installation_header "Creating Git folders"

    user_home="/home/$username"

    as_user mkdir -p $user_home/git
    as_user mkdir -p $user_home/sys-git

    echo "Created 'git' and 'sys-git' folders in '$username' home."

    repo_name="dots"
    echo "Cloning '$repo_name' repo..."

    as_user git clone https://github.com/evanasse/$repo_name $user_home/git/$repo_name

    if [[ $? -eq 0 ]]; then
        echo "Cloned '$repo_name' repo in '$username' home."
    fi

    increment_start_point
fi


#######################################
#
# INSTALL RUST
#
#######################################
if [[ $start_point -eq 4 && $start_point -le $end_point ]]; then
    installation_header "Installing Rust"

    as_user apt install rustup

    as_user rustup toolchain install beta
    as_user rustup default beta

    echo "Rust installed."

    increment_start_point
fi


#######################################
#
# INSTALL DESKTOP ENVIRONMENT STUFF
#
#######################################
if [[ $start_point -eq 6 && $start_point -le $end_point ]]; then
    installation_header "Installing desktop environment stuff"

    as_user apt install -y feh picom rofi ttf-ubuntumono-nerd xorg-server xorg-xinit gtk3 gtk-layer-shell pango gdk-pixbuf2 cairo glib2 gcc-libs glibc
    as_user cargo install leftwm

    as_user git clone https://github.com/elkowar/eww /home/$username/sys-git/eww

    cd /home/$username/sys-git/eww

    as_user cargo build --release

    as_user chmod +x /home/$username/sys-git/eww/target/release/eww

    echo "Desktop environment stuff installed."

    increment_start_point
fi


#######################################
#
# INSTALL TERMINAL STUFF
#
#######################################
if [[ $start_point -eq 7 && $start_point -le $end_point ]]; then
    installation_header "Installing terminal stuff"

    as_user apt install -y alacritty tmux starship nushell

    as_user usermod $username -s /usr/bin/nu

    echo "Terminal stuff installed."

    increment_start_point
fi


#######################################
#
# INSTALL SYSTEM PACKAGES
#
#######################################
if [[ $start_point -eq 8 && $start_point -le $end_point ]]; then
    installation_header "Installing various system packages"

    as_user apt install -y man ripgrep fd

    echo "Various system packages installed."

    increment_start_point
fi


#######################################
#
# INSTALL NEOVIM
#
#######################################
if [[ $start_point -eq 9 && $start_point -le $end_point ]]; then
    installation_header "Installing Neovim"

    as_user apt install -y cmake unzip ninja tree-sitter curl npm

    as_user git clone https://github.com/neovim/neovim /home/$username/sys-git/neovim

    cd /home/$username/sys-git/neovim

    as_user make CMAKE_BUILD_TYPE=Release

    as_user sudo make install

    echo "Neovim installed."

    increment_start_point
fi

#######################################
#
# INSTALL AUDIO STUFF
#
#######################################
if [[ $start_point -eq 10 && $start_point -le $end_point ]]; then
    installation_header "Installing audio stuff"

    as_user paru -Sy --noconfirm pipewire pipewire-pulse pipewire-jack pipewire-alsa wireplumber qpwgraph

    usermod -aG audio $username

    echo "Audio stuff installed."

    increment_start_point
fi

#######################################
#
# INSTALL EXTRA APPS
#
#######################################
if [[ $start_point -eq 11 && $start_point -le $end_point ]]; then
    installation_header "Installing extra apps"

    as_user paru -Sy --noconfirm librewolf-bin networkmanager

    systemctl enable NetworkManager
    systemctl start NetworkManager

    echo "Extra apps installed."

    increment_start_point
fi
