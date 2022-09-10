#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/echoes.sh"
source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/user-exists.sh"
source "$(dirname "${BASH_SOURCE[0]}")/bash-utils/read-username.sh"

username=$(read_username)

if user_exists $username; then
    err_echo "User \'$username\' already exists. Nothing to do."
else
    ok_echo "Creating new user..."

    useradd -m -G users,wheel $username
    passwd $username

    # Roll back user creation
    if ! $?; exit_code=$?; then
        userdel -r $username
        err_echo "Error during user creation. Rolling back changes."

        exit $exit_code
    fi

    ok_echo "User \'$username\' created."
fi
