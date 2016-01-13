#!/bin/sh

brew install nvm

echo
echo "Initializing nvm..."

mkdir -p ~/.nvm
cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
export NVM_DIR=~/.nvm
# shellcheck source=/dev/null
. "$(brew --prefix nvm)/nvm.sh"

echo "done."

# Installing nodejs with nvm

echo
echo "Installing nodejs..."

nvm install node 2>&1
# FIXME if set -e is set, script exists.
# Possible solution for now is to redirect STDERR to STDOUT
# e.g. nvm install node 2>&1
nvm alias default node
# FIXME running this seems to break npm when install node 5.4.1 and npm 3.3.12
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
