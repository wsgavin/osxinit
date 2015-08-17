#!/bin/sh

#
# Bash script to install Homebrew, applications and some minor configurations
# to utilize the new installed application.
#

set -e

# Instll homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
brew doctor

brew install coreutils
brew install findutils
brew install gnu-sed --with-default-names
brew install homebrew/dupes/grep --with-default-names
brew install bash
brew install bash-completion

brew install vim --override-system-vi
brew install git
brew install wget
brew install ack
brew install ffmpeg
brew reinstall ffmpeg --with-faac
brew install nmap
brew install nvm
brew install rbenv
brew install ruby-build
brew install jenv
brew install ctags

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install google-chrome
brew cask install spotify
brew cask install microsoft-office
brew cask install 1password
brew cask install dropbox
brew cask install crashplan
brew cask install clamxav
brew cask install vlc
brew cask install handbrake
brew cask install makemkv
brew cask install the-unarchiver
brew cask install silverlight
brew cask install gopro-studio
brew cask install real-vnc
brew cask install transmission
brew cask install java7
brew cask install java
brew cask install sublime-text3
brew cask install parallels-desktop
brew cask install minecraft
brew cask install cleanmymac
brew cask install snagit
brew cask install skype
brew cask install github-desktop
brew cask install adobe-reader
brew cask install eclipse-java

brew cleanup
brew cask cleanup

# Installing gvm, currently not in homebrew
curl -s get.gvmtool.net | bash

exit 0

# Non brew cask installs
#
# Western Digital Disk Utilities
# Brother P-Touch software (lable maker)
#
# Apps purchased through App Store
#
# Day One
# Gemini
#
