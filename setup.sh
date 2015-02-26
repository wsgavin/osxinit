#!/bin/sh

# Initialze home directory with dotfiles.
# DO SOMETHING HERE...

# Installing Ruby with rbenv.
rbenv install 2.2.0
rbenv global 2.2.0
# Initialize Ruby environment so gems are installed in the correct location.
eval "$(/usr/local/bin/rbenv init -)"
gem install compass

# Installing nodejs with nvm
mkdir ~/.nvm
export NVM_DIR=~/.nvm
# Initialize nodejs environment so node modules are installed in the correct location.
source $(brew --prefix nvm)/nvm.sh

nvm install v0.10.36
nvm alias default v0.10.36
nvm use default

echo
echo Close this terminal and open a new one.
echo

exit 0
