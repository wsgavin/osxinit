#!/usr/bin/env bash

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

brew cleanup

exit 0
