#!/bin/sh

# TODO
#
# Added this part here because it seems that something after this point resets
# the sudo timeout "I think."
#

echo
echo "Adding homebrew version of bash to /etc/shells..."

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi



echo
printf "Initializing home directory with dotfiles..."
cp -r home/.[!.]* ~/
echo "done."
