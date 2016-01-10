#!/bin/sh

brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils
brew install findutils --with-default-names
brew install gnu-sed --with-default-names
brew install ack
brew install tmux
brew install ffmpeg --with-faac
brew install nmap
brew install wget
brew install ctags
brew install shellcheck

brew tap homebrew/dupes
brew install homebrew/dupes/grep --with-default-names
