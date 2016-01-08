#!/bin/sh

# Copy all a few of our dotfiles in to our home directory and adding
# /usr/local/bin & /usr/local/opt/coreutils/libexec/gnubin to utilize in this
# script.

#
# TODO: Find proper regex for email address.
#

echo
echo "The following script will configure some personal settings.  Press"
echo "Return to accept the defaults in brackets."
echo

# S_EMAIL="$(/usr/libexec/PlistBuddy -c "Print" ~/Library/Preferences/com.apple.ids.service.com.apple.madrid.plist | grep LoginAs | sed 's/.*LoginAs = //' 2>/dev/null)"
# S_FULLNAME="$(osascript -e 'long user name of (system info)')"

# s_entered_email=""
# s_entered_full_name=""
# regex_email="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# # Ask for full name for git.

# echo "Configuring git settings..."
# echo

# while [ -z "$s_entered_full_name" ]
# do

#   # shellcheck disable=SC2039 disable=SC2162
#   read -p "Enter full name [$S_FULLNAME]: " s_entered_full_name

#   if [ -z "$s_entered_full_name" ]; then
#     s_entered_full_name="$S_FULLNAME"
#   fi

#   # shellcheck disable=SC2039 disable=SC2162
#   read -p "Confirm full name '$s_entered_full_name' [Y/n]: " yn

#   case "$yn" in
#     ""|[Yy])
#         S_FULLNAME="$s_entered_full_name"
#       ;;
#     *)
#       s_entered_full_name=""
#       ;;
#   esac

#   if [ -z "$s_entered_full_name" ]; then
#     echo "Something is wrong, let's try again."
#   fi

# done

# # Ask for valid email address for git.

# while [ -z "$s_entered_email" ]
# do

#   # shellcheck disable=SC2039 disable=SC2162
#   read -p "Enter new email address [$S_EMAIL]: " s_entered_email

#   if [ -z "$s_entered_email" ]; then
#     s_entered_email="$S_EMAIL"
#   fi

#   # shellcheck disable=SC2039 disable=SC2162
#   read -p "Confirm email address '$s_entered_email' [Y/n]: " yn

#   case "$yn" in
#     ""|[Yy])
#       # shellcheck disable=SC2039
#       if [[ "$s_entered_email" =~ $regex_email ]]; then
#         S_EMAIL="$s_entered_email"
#       else
#         s_entered_email=""
#       fi
#       ;;
#     *)
#       s_entered_email=""
#       ;;
#   esac

#   if [ -z "$s_entered_email" ]; then
#     echo "Something is wrong, let's try again."
#   fi

# done

# echo
# echo "Completing git personal settings..."

# echo
# echo Initializing the home directory with dotfiles.
# cp -r home/.[!.]* ~/

# Setting up the PATH for this script to work.

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/php56/bin:$PATH"

# Add the homebrew version of bash to /etc/shells

# echo
# echo Adding homebrew version of bash to /etc/shells...

# if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
#   # TODO Not sure why I had to do this but it appears to work.
#   echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
# fi

# Change the default shell for the current user

# echo
# echo Setting shell...
# chsh -s /usr/local/bin/bash

# Future enhancements:
# - Pass name & email as arguments

# The following is my personal settings for git.

# echo
# echo Configuring git...

# git config --global user.name "$S_FULLNAME"
# git config --global user.email "$S_EMAIL"
# git config --global core.autocrlf input
# git config --global core.safecrlf true
# git config --global core.editor vim
# git config --global merge.tool vimdiff
# git config --global color.ui auto
# git config --global push.default simple
# git config --global format.pretty "%h - %an, %ar : %s"

# Initializing vim

# echo
# echo Initializing vim...

# mkdir "$HOME/.vim"
# mkdir "$HOME/.vim/backups"
# mkdir "$HOME/.vim/swaps"
# mkdir "$HOME/.vim/undo"
# mkdir "$HOME/.vim/autoload"
# mkdir "$HOME/.vim/bundle"

# # Install pathogen
# curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

# # Installing some plugins
# git clone git://github.com/tpope/vim-sensible.git \
#   "$HOME/.vim/bundle/vim-sensible"
# git clone git://github.com/altercation/vim-colors-solarized.git \
#   "$HOME/.vim/bundle/vim-colors-solarized"


# Installing Ruby with rbenv.

# echo
# echo Installing Ruby...

# # Found this sed command to find the latest version of ruby from rbenv.
# # Shellcheck does not like the $ inside the single quotes. I'm not a sed expert
# # and not sure what to do to resolve the check. Ignoring for now as it works.
# #
# # shellcheck disable=SC2016
# RUBY_VER="$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}' | tr -d '[:space:]')"

# rbenv install "$RUBY_VER"
# rbenv global "$RUBY_VER"

# # Initialize Ruby environment so gems are installed in the correct location.

# echo
# echo Initializing rbenv...
# eval "$(/usr/local/bin/rbenv init -)"
# echo
# echo Installing compass

# gem install compass
# rbenv rehash


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

#echo
#echo Initialize mysql
#mysql.server start

# mysql_secure_installation
# TODO Ask for this upfront.
# stty -echo
# printf "Enter desired MySQL root password: "
# read -r mysql_password
# stty echo
# printf "\n\n%s\n%s\n\n\n\n\n" "$mysql_password" "$mysql_password" | mysql_secure_installation 2>/dev/null
# mysql.server stop
# echo
# echo Close this terminal and open a new one.
# echo

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

exit 0
