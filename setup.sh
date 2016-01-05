#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

echo
echo Initializing the home directory with dotfiles.
cp -r home/.[!.]* ~/

# Setting up the PATH for this script to work.

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/php56/bin:$PATH"

# Add the homebrew version of bash to /etc/shells

echo
echo Adding homebrew version of bash to /etc/shells...

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  # TODO Not sure why I had to do this but it appears to work.
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi

# Change the default shell for the current user

echo
echo Setting shell...
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
mkdir "$HOME/.vim/autoload"
mkdir "$HOME/.vim/bundle"

# Install pathogen
curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

# Installing some plugins
git clone git://github.com/tpope/vim-sensible.git \
  "$HOME/.vim/bundle/vim-sensible"
git clone git://github.com/altercation/vim-colors-solarized.git \
  "$HOME/.vim/bundle/vim-colors-solarized"


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
npm update --global

# Install node modules.

echo
echo Installing node modules...

npm install --global \
  yo \
  grunt-cli \
  bower \

npm cache clean

echo
echo Initializing jenv...

eval "$(jenv init -)"

# Loops through all the Java installs and adds them to jenv.
for f in /Library/Java/JavaVirtualMachines/*
do
    jenv add "$f/Contents/Home"
done

jenv rehash

#echo
#echo Initializing php

# To enable PHP in Apache add the following to httpd.conf and restart Apache:
#    LoadModule php5_module    /usr/local/opt/php56/libexec/apache2/libphp5.so

# The php.ini file can be found in:
#     /usr/local/etc/php/5.6/php.ini


echo
echo Initializing python

mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> \
  "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

mkdir "$HOME/.virtualenvs"
pip install --upgrade --no-use-wheel pip setuptools
#pip install --upgrade setuptools
pip install virtualenv
pip install virtualenvwrapper

echo
echo Initialize mysql
mysql.server start
mysql_secure_installation
mysql.server stop

echo
echo Close this terminal and open a new one.
echo

exit 0
