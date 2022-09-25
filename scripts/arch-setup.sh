#!/bin/bash

set -e

#######################################
#
# CREATE USER
#
#######################################
echo "Creating user..."

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


#######################################
#
# INSTALL SUDO
#
#######################################
pacman -Sy sudo

sed -i "s/#wheel ALL=(ALL) NOPASS/wheel ALL=(ALL) NOPASS/" /etc/sudoers

as_user(){
    sudo --shell --set-home --user $username $@
}

#######################################
#
# MAKE GIT DIRECTORIES
#
#######################################
echo "Creating Git folders..."

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


#######################################
#
# INSTALL RUST
#
#######################################
echo "Install Rust tools..."

as_user curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

as_user source $HOME/.cargo/env

as_user rustup toolchain install beta
as_user rustup default beta
