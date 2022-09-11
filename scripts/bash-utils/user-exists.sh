#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/echoes.sh"

user_exists() {
    if id "$1" &>/dev/null; then
        exit_code=$?
    else
        exit_code=$?
        echo_code $exit_code "User '$1' does not exist."
    fi

    return $exit_code
}
