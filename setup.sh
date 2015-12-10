#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

echo
echo Installing Ruby...

# Found this sed command to find the latest version of ruby from rbenv.
# Shellcheck does not like the $ inside the single quotes. I'm not a sed expert
# and not sure what to do to resolve the check. Ignoring for now as it works.
# 
# shellcheck disable=SC2016
RUBY_VER="$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}' | tr -d '[:space:]')"

rbenv install "$RUBY_VER"
rbenv global "$RUBY_VER"

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
nvm alias default node
npm update -g

# Install node modules.

#echo
#echo Installing node modules...

#npm install -g \
#  yo \
#  grunt \
#  grunt-cli \
#  bower \
#  generator-angularfire \
#  firebase-tools

#npm cache clean

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

mkdir "$HOME/.virtualenvs"
pip install --upgrade setuptools
pip install virtualenv
pip install virtualenvwrapper



#mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
#echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' \
#    >> /Users/warren/Library/Python/2.7/lib/python/site-packages/homebrew.pth
#echo "$(brew --prefix)/lib/python2.7/site-packages" > \
#    "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

echo
echo Close this terminal and open a new one.
echo

exit 0
