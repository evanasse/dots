#!/bin/bash

set -e

username=$1

useradd -m -G users,wheel $username
