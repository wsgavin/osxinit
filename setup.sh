#!/bin/sh

rbenv install 2.2.0
rbenv global 2.2.0
eval "$(/usr/local/bin/rbenv init -)"
gem install compass

mkdir ~/.nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

nvm install v0.10.36
nvm alias default v0.10.36
nvm use default
