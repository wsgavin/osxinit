#!/bin/sh


function abort {
  echo "$1"
  exit 1
}

set -e

# Determine if the Xcode command line tools installed.

XCODE_SELECT="$(xcode-select -p 2>&1)";

if [[ $XCODE_SELECT == "/Library/Developer/CommandLineTools" || \
  $XCODE_SELECT == "/Applications/Xcode.app/Contents/Developer" ]]
  then
    echo "Xcode command line tools installed."
  else
    echo "Xcode is not installed."
    xcode-select --install
fi

command -v /usr/bin/git >/dev/null 2>&1 || abort "Xcode command line tools git not found!" 

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
brew install vim
brew install ack
brew install ffmpeg
brew reinstall ffmpeg --with-faac
brew install nmap
brew install nvm
brew install rbenv
brew install ruby-build
brew install caskroom/cask/brew-cask

brew cask install clamxav
brew cask install vlc
brew cask install firefox
brew cask install handbrake
brew cask install makemkv
brew cask install spotify
brew cask install the-unarchiver
brew cask install google-chrome
#brew cask install parallels-desktop
brew cask install mailbox
brew cask install silverlight
brew cask install gopro-studio
brew cask install real-vnc
#brew cask install cleanmymac
#brew cask install snagit
brew cask install dropbox
brew cask uninstall crashplan
#brew cask install sublime-text
brew cask install transmission
#brew cask install minecraft
#brew cask install 

brew cleanup

# Add the homebrew version of bash to /etc/shells

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  echo "/usr/local/bin/bash" >> /etc/shells
fi

# Change the default shell for the current user

chsh -s /usr/local/bin/bash

exit 0
