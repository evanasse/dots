#!/bin/bash

set -e

if [[ -z $1 ]]; then
    echo -n "Enter username to create: "
    read username
else
    username=$1
fi

useradd -m -G users,wheel $username
passwd $username
