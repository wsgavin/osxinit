#!/bin/bash

# Cleaning up old node directories to start fresh.
rm -rf ${HOME}/.node-gyp \
  ${HOME}/.npm \
  ${HOME}/.npmrc \
  ${HOME}/.nvm

# Determine the latest version of nodejs.
latest=$(curl -silent http://nodejs.org/dist/latest/ | \
  grep -o 'v[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.pkg' | \
  head -1 | \
  sed 's/\.pkg//')

# Install nvm
echo
echo Installing nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

BASH_STR="\n[[ -r \$NVM_DIR/bash_completion ]] && . \$NVM_DIR/bash_completion"

if ! grep -qc 'NVM_DIR/bash_completion' $PROFILE; then
  echo "=> Appending bash completion string to $PROFILE"
  printf "$BASH_STR\n" >> "$PROFILE"
else
  echo "=> Source string already in $NVM_PROFILE"
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# Install latest node
echo
echo Installing nodejs...
nvm install $latest
nvm alias default $latest

echo
echo Configuring npm...
npm config set loglevel warn

echo
echo To start using node type the following command:
echo   $ nvm use $latest
echo

exit 0
