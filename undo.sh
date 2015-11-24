#!/bin/sh

# MAKE SURE YOU ARE HAPPY WITH WHAT IT DOES FIRST! THERE IS NO WARRANTY!
#
# ASSUMPTION /usr/local & /opt can be fully deleted.


 abort() {
  echo "$1"
  exit 1
}

set -e

/usr/bin/which -s brew || abort "No homebrew installed!"

# TODO brew cask list to uninstall

brew cask uninstall google-chrome
brew cask uninstall spotify
brew cask uninstall microsoft-office
brew cask uninstall 1password
brew cask uninstall mailbox
brew cask uninstall dropbox
brew cask uninstall crashplan
brew cask uninstall clamxav
brew cask uninstall vlc
brew cask uninstall handbrake
brew cask uninstall makemkv
brew cask uninstall the-unarchiver
brew cask uninstall silverlight
brew cask uninstall gopro-studio
brew cask uninstall real-vnc
brew cask uninstall transmission
brew cask uninstall java7
brew cask uninstall java
brew cask uninstall parallels-desktop
brew cask uninstall minecraft
brew cask uninstall sublime-text3
brew cask uninstall cleanmymac
brew cask uninstall snagit

# Cleaning up home directory
rm -rf ~/.cache
rm -rf ~/.local
rm -rf ~/.subversion
rm -rf ~/.rbenv
rm -rf ~/.gem
rm -rf ~/.npm
rm -rf ~/.nvm
rm -rf ~/.gvm
rm -rf ~/.jenv
rm -rf ~/.vnc
rm ~/.vimrc
rm ~/.viminfo
rm -rf ~/.vim
rm -rf ~/.dotfiles
rm -rf ~/.ctags
rm ~/.hushlogin
rm ~/.gitconfig
rm ~/.bash*
rm -rf ~/Applications
rm ~/Downloads/javaforosx.dmg
rm -rf ~/Library/Caches/Homebrew
rm -rf ~/Library/Logs/Homebrew

sudo rm -rf /usr/local
sudo rm -rf /Library/Caches/Homebrew
sudo rm -rf /opt
