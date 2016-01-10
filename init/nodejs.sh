#!/bin/sh

set -x

brew install nvm


echo
echo "Initializing nvm..."

mkdir -p ~/.nvm
cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
export NVM_DIR=~/.nvm
# shellcheck source=/dev/null
source "$(brew --prefix nvm)/nvm.sh"

echo "done."

# Installing nodejs with nvm

echo
echo "Installing nodejs..."

nvm install node
# FIXME Something is happening where after the install the script just stops...
#nvm alias default node
#npm update --global

echo "done."

# Install node modules.

echo
echo Installing node modules...

npm install --global \
  yo \
  grunt-cli \
  bower \

npm cache clean

echo "done."

set +x
