#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/echoes.sh"
source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/user-exists.sh"
source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/read-username.sh"

if [[ -z $1 ]]; then
    read_username
else
    username=$1
fi

if user_exists $username; then
    exit_code=$?
    echo_code $exit_code "User '$username' already exists. Nothing to do."
else
    exit_code=$?
    echo_code $? "Creating new user..."

    useradd -m -G users,wheel $username
    passwd $username

    # Roll back user creation
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo_code $exit_code "Error during user creation. Rolling back changes."
        userdel -r $username

        exit $exit_code
    fi

    echo_code $exit_code "User '$username' created."
fi
