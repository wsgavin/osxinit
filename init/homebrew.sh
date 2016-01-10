#!/bin/sh

# Install Homebrew http://brew.sh
#
# Redirecting STDIN to /dev/null so one does not have to press Return to
# continue.

ruby -e "$(curl \
  -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  </dev/null

brew update
brew upgrade
brew doctor
