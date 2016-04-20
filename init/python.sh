#!/bin/sh


brew install pyenv

eval "$(pyenv init -)"

echo
echo "Installing python..."

pyenv install 2.7.11
pyenv install 3.5.1


echo
echo "Initializing python..."

#mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
#echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> \
#  "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

mkdir -p "$HOME/.virtualenvs"

pyenv local 2.7.11

pip install --upgrade --no-use-wheel pip setuptools
pip install virtualenvwrapper

pyenv local 3.5.1

pip install --upgrade --no-use-wheel pip setuptools
pip install virtualenvwrapper

pyenv global 2.7.11

echo "done."
