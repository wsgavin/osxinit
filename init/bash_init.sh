#!/bin/sh

echo
printf "Initializing home directory with dotfiles..."
cp -r home/.[!.]* ~/
echo "done."
