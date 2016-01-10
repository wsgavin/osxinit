#!/bin/sh


echo "$sudo_password" | sudo -S mkdir -p /opt
sudo chmod 0775 /opt

sudo mkdir -p /opt/homebrew-cask/Caskroom
sudo chown -R warren:staff /opt/homebrew-cask/

brew tap caskroom/cask

#brew tap caskroom/versions
#brew install caskroom/cask/brew-cask
