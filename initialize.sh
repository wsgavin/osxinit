#!/bin/sh

#
# Bash script to install Homebrew, applications and some minor configurations
# to utilize the new installed application.
#

set -e

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install homebrew
ruby -e "$(curl -fsSL \
    https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
brew doctor

brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php

brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils
brew install findutils --with-default-names
brew install gnu-sed --with-default-names
brew install ack
brew install homebrew/dupes/grep --with-default-names

brew install bash
brew install bash-completion2

brew install vim --override-system-vi
brew install git
brew install wget

brew install ffmpeg
brew reinstall ffmpeg --with-faac
brew install nmap
brew install nvm
brew install rbenv
brew install ruby-build
brew install jenv
brew install ctags
brew install shellcheck
brew install python

# MySQL
brew install mysql

# PHP 
brew install zlib
brew install homebrew/php/php56 --with-pear
brew install php56-mcrypt
brew install composer




# Install cask...

brew tap caskroom/versions
brew install caskroom/cask/brew-cask

brew cask install adobe-reader
brew cask install arduino
brew cask install cleanmymac
brew cask install dropbox
brew cask install google-chrome
brew cask install handbrake
brew cask install java
brew cask install java7
brew cask install makemkv
brew cask install parallels-desktop
brew cask install real-vnc
brew cask install silverlight
brew cask install spotify
brew cask install sublime-text3
brew cask install the-unarchiver
brew cask install transmission
brew cask install vlc
brew cask install sophos-anti-virus-home-edition
brew cask install malwarebytes-anti-malware

#brew cask install 1password
#brew cask install clamxav
#brew cask install eclipse-java
#brew cask install microsoft-office
#brew cask install crashplan
#brew cask install github-desktop
#brew cask install gopro-studio
#brew cask install minecraft
##brew cask install skype
#brew cask install snagit

brew cleanup
brew cask cleanup

# Downloading Apple's version of Java. I am not sure how I will do this via
# command line as of yet.
echo "Downloading Apple's version of Java 6. The install file be located in \
    your Downloads directory. Double click javaforosx.dmg and install the \
    package and follow the prompts."
wget -O ~/Downloads/javaforosx.dmg \
  https://support.apple.com/downloads/DL1572/en_US/javaforosx.dmg
echo
echo "Don't forget to install!"

hdiutil attach ~/Downloads/javaforosx.dmg

exit 0

# Non brew cask installs
#
# Western Digital Disk Utilities
# Brother P-Touch software (label maker)
#
# Apps purchased through App Store
#
# Day One
# Gemini
#
