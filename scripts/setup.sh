#!/bin/bash

set -e


username=$(bash ./as-root/create-user.sh)

./as-root/install-sudo.sh

sudo -u $username -e ./as-user/make-git-dirs.sh
sudo -u $username -e ./as-user/install-rustup.sh
