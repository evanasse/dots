#!/bin/bash

source "$(dirname "$BASH_SOURCE[0]")/bash-utils/echoes.sh"
source "$(dirname "$BASH_SOURCE[0]")/bash-utils/user-exists.sh"
source "$(dirname "$BASH_SOURCE[0]")/bash-utils/read-username.sh"

echo_code $? "Creating Git folders..."

if [[ -z $1 ]]; then
    read_username
else
    username=$1
fi

if user_exists $username; then
    user_home="/home/$username"
    mkdir -p $user_home/git
    mkdir -p $user_home/sys-git
    echo_code $? "Created 'git' and 'sys-git' folders in '$username' home."
else
    exit $? 
fi

echo_code $? "Cloning 'dots' repo..."

repo_name="dots"
git clone https://github.com/evanasse/$repo_name $user_home/git/$repo_name

if [[ $? -eq 0 ]]; then
    echo_code $? "Cloned 'dots' repo in '$username' home."
fi
