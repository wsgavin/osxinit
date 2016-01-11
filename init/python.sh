#!/bin/sh


brew install python


echo
echo "Initializing python..."

mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> \
  "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

mkdir -p "$HOME/.virtualenvs"

pip install --upgrade --no-use-wheel pip setuptools
#pip install --upgrade setuptools
pip install virtualenv
pip install virtualenvwrapper

echo "done."
