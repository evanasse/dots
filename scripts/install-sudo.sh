#!/bin/bash

set -e

pacman -Sy sudo

sed -i "s/#wheel ALL=(ALL) NOPASS/wheel ALL=(ALL) NOPASS/"
