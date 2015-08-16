#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

echo
echo Initializing the home directory with dotfiles.
cp -r home/.[^.]* ~/
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Add the homebrew version of bash to /etc/shells

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  echo "/usr/local/bin/bash" >> /etc/shells
fi

# Change the default shell for the current user

chsh -s /usr/local/bin/bash

# Future enhancements:
# - Pass name & email as arguments

# The following is my personal settings for git.

git config --global user.name "Warren Gavin"
git config --global user.email "warren@dubelyoo.com"
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global color.ui auto
git config --global push.default simple
git config --global format.pretty "%h - %an, %ar : %s"

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

nvm install v0.12.7
nvm alias default v0.12.7
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
echo Initializing groovy
# Not yet in brew

source "$HOME/.gvm/bin/gvm-init.sh"
gvm install groovy

echo
echo Initializing jenv

jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home

echo
echo Close this terminal and open a new one.
echo

exit 0
