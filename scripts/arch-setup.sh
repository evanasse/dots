#!/bin/bash

set -e

echo "Starting points:"
echo "[0] Upgrade system packages"
echo "[1] Create user"
echo "[2] Install 'sudo'"
echo "[3] Make Git directories"
echo "[4] Install Rust"
echo "[5] Install Paru"
echo "[6] Install window manager stuff"
read -p "Select starting point [0]: " start_point
read -p "Select ending point [6]: " end_point

if [[ -z $start_point ]]; then
    start_point=0
fi
if [[ -z $end_point ]]; then
    end_point=6
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

read -p "Enter target username: " username

#######################################
#
# UPGRADE SYSTEM PACKAGES
#
#######################################
if [[ $start_point -eq 0 && $start_point -le $end_point ]]; then
    installation_header "Upgrading system packages"

    pacman -Syu --noconfirm

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

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | as_user sh -s -- -y

    as_user /home/$username/.cargo/bin/rustup toolchain install beta
    as_user /home/$username/.cargo/bin/rustup default beta

    echo "Rust installed."
    
    increment_start_point
fi


#######################################
#
# INSTALL PARU
#
#######################################
if [[ $start_point -eq 5 && $start_point -le $end_point ]]; then
    installation_header "Installing Paru"

    as_user sudo pacman -Syu --needed base-devel

    as_user git clone https://aur.archlinux.org/paru.git /home/$username/sys-git/paru

    cd /home/$username/sys-git/paru

    as_user makepkg -si

    echo "Paru installed."
    
    increment_start_point
fi


#######################################
#
# INSTALL WINDOW MANAGER STUFF
#
#######################################
if [[ $start_point -eq 6 && $start_point -le $end_point ]]; then
    installation_header "Installing window manager stuff"

    as_user paru -Syu feh picom leftwm

    echo "Window manager stuff installed."
fi


#######################################
#
# INSTALL TERMINAL STUFF
#
#######################################
if [[ $start_point -eq 6 && $start_point -le $end_point ]]; then
    installation_header "Installing window manager stuff"

    as_user paru -Syu alacritty

    echo "Window manager stuff installed."
fi
