#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/echoes.sh"

user_exists() {
    if ! id "$1" &>/dev/null; exit_code=$?; then
        err_echo "User \'$1\' does not exist." >&2
    fi

    return $exit_code
}
