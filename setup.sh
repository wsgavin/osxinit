#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

echo
echo Initializing the home directory with dotfiles.
cp -r home/.[!.]* ~/

# Setting up the PATH for this script to work.

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Add the homebrew version of bash to /etc/shells

echo
echo Adding homebrew version of bash to /etc/shells

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  # TODO Not sure why I had to do this but it appears to work.
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi

# Change the default shell for the current user

echo
chsh -s /usr/local/bin/bash

# Future enhancements:
# - Pass name & email as arguments

# The following is my personal settings for git.

echo
echo Configuring git...

git config --global user.name "Warren Gavin"
git config --global user.email "warren@dubelyoo.com"
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global color.ui auto
git config --global push.default simple
git config --global format.pretty "%h - %an, %ar : %s"

# Initializing vim

echo
echo Initializing vim...

mkdir "$HOME/.vim"
mkdir "$HOME/.vim/backups"
mkdir "$HOME/.vim/swaps"
mkdir "$HOME/.vim/undo"


# Installing Ruby with rbenv.
# TODO: Find out how to get the latest version. rbenv install -l lists them all.

echo
echo Installing Ruby...

rbenv install 2.2.3
rbenv global 2.2.3

# Initialize Ruby environment so gems are installed in the correct location.

echo
echo Initializing rbenv...
eval "$(/usr/local/bin/rbenv init -)"
echo
echo Installing compass

gem install compass
rbenv rehash


# Initialize nvm environment

echo
echo Initializing nvm...

mkdir ~/.nvm # TODO add test for directory
cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
export NVM_DIR=~/.nvm
# shellcheck source=/dev/null
source "$(brew --prefix nvm)/nvm.sh"

# Installing nodejs with nvm

echo
echo Installing nodejs...

nvm install node

# Install node modules.

echo
echo Installing node modules...

npm install -g \
  yo \
  grunt \
  grunt-cli \
  bower \
  generator-angularfire \
  firebase-tools

npm cache clean

#echo
#echo Initializing groovy...
# Not yet in brew

# shellcheck source=/dev/null
#source "$HOME/.sdkman/bin/sdkman-init.sh"
#gvm install groovy

# gvm creates this, no need for it
#rm ~/.zshrc

echo
echo Initializing jenv...

eval "$(jenv init -)"

# Loops through all the Java installs and adds them to jenv.
for f in /Library/Java/JavaVirtualMachines/*
do
    jenv add "$f/Contents/Home"
done

jenv rehash

echo
echo Initializing python

mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> \
  "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

#mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
#echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' \
#    >> /Users/warren/Library/Python/2.7/lib/python/site-packages/homebrew.pth
#echo "$(brew --prefix)/lib/python2.7/site-packages" > \
#    "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

echo
echo Close this terminal and open a new one.
echo

exit 0
