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

echo home = $HOME

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

echo nvm dir = $NVM_DIR

# Install latest node
echo
echo Installing nodejs...
nvm install $latest
#nvm install v0.10.36 
#nvm install v0.11.16 

echo
echo node `node --version`
echo npm `npm --version`
echo
echo Configuring npm...
npm config set loglevel warn

# Install yeoman
echo
echo Installing yeoman...
npm cache clean
npm install -g yo

# Install grunt & grunt-cli
echo
echo Installing grunt \& grunt-cli...
npm cache clean
npm install -g grunt
npm install -g grunt-cli

# Install bower
echo
echo Installing bower...
npm cache clean
npm install -g bower

# Install generator-angularfire
echo
echo Installing generator-angularfire...
npm cache clean
npm install -g generator-angularfire

# Install firebase-tools
echo
echo Installing firebase-tools...
npm cache clean
npm install -g firebase-tools

# Cleanup
#sudo chown -R $SUDO_USER:wheel /usr/local
npm cache clean

exit 0
