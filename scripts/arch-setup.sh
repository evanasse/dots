#!/bin/bash

set -e

echo "Starting points:"
echo "[0] Upgrade system packages"
echo "[1] Create user"
echo "[2] Install 'sudo'"
echo "[3] Make Git directories"
echo "[4] Install Rust"
echo -n "Select starting point: "
read start_point

increment_start_point(){
    start_point=$start_point+1
}

as_user(){
    sudo --shell --set-home --user $username $@
}

if [[ $start_point -gt 1 ]]; then
    echo -n "Enter target username: "
    read username
fi

#######################################
#
# UPGRADE SYSTEM PACKAGES
#
#######################################
if [[ $start_point -eq 0 ]]; then
    echo ""
    echo "//// Upgrading system packages..."
    echo ""

    pacman -Syu --noconfirm

    increment_start_point
fi

#######################################
#
# CREATE USER
#
#######################################
if [[ $start_point -eq 1 ]]; then
    echo ""
    echo "//// Creating user..."
    echo ""

    echo -n "Enter target username: "
    read username

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
if [[ $start_point -eq 2 ]]; then
    echo ""
    echo "//// Installing 'sudo'..."
    echo ""

    pacman -Sy --noconfirm sudo

    sed -i "s/#wheel ALL=(ALL) NOPASS/wheel ALL=(ALL) NOPASS/" /etc/sudoers

    echo "'sudo' installed."
    
    increment_start_point
fi

#######################################
#
# MAKE GIT DIRECTORIES
#
#######################################
if [[ $start_point -eq 3 ]]; then
    echo ""
    echo "//// Creating Git folders..."
    echo ""

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
if [[ $start_point -eq 4 ]]; then
    echo ""
    echo "//// Installing Rust..."
    echo ""

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | as_user sh -s -- -y

    as_user source \$HOME/.cargo/env; rustup toolchain install beta
    as_user source \$HOME/.cargo/env; rustup default beta

    echo "Rust installed."
    
    increment_start_point
fi
