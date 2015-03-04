#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

echo
echo Initializing the home directory with dotfiles.
cp -r home/.[^.]* ~/
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Installing Ruby with rbenv.

echo
echo Installing Ruby.
rbenv install 2.2.0
rbenv global 2.2.0

# Initialize Ruby environment so gems are installed in the correct location.

echo
echo Initializing rbenv...

eval "$(/usr/local/bin/rbenv init -)"

echo
echo Installing compass
gem install compass


# Initialize nvm environment

echo
echo Initializing nvm...

mkdir ~/.nvm # TODO add test for directory
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Installing nodejs with nvm

echo
echo Installing nodejs.

nvm install v0.10.36
nvm alias default v0.10.36
nvm use default

# Install node modules.

echo
echo Installing node modules.

npm install -g \
  yo \
  grunt \
  grunt-cli \
  bower \
  generator-angularfire \
  firebase-tools

npm cache clean

echo
echo Close this terminal and open a new one.
echo

exit 0
