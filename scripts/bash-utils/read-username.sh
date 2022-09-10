#!/bin/bash

read_username() {
    if [[ -z $1 ]]; then
        echo -n "Enter username: "
        read username
    else
        username=$1
    fi
    echo $username
}
