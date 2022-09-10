#!/bin/bash

set -e

echo "~> Creating git folders..."

if [[ -z $1 ]]; then
    echo -n "Enter username: "
    read username
else
    username=$1
fi

if ! id "$username" &> /dev/null; then
    echo "<~ User \'$username\' does not exist."
    exit 1
else
    user_home="/home/$username"
    mkdir $user_home/git
    mkdir $user_home/sys-git
    echo "~> Created 'git' and 'sys-git' folders in \'$username\' home."
fi

echo "~> Cloning 'dots' repo..."

repo_name="dots"
git clone https://github.com/evanasse/$repo_name $user_home/git/$repo_name

echo "~> Cloned 'dots' repo in \'$username\' home."
