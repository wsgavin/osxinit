#!/bin/sh

# Just copy and paste the lines below (all at once, it won't work line by line!)
# MAKE SURE YOU ARE HAPPY WITH WHAT IT DOES FIRST! THERE IS NO WARRANTY!


# Utilized the gist from https://gist.github.com/mxcl/1173223
# Added a few personal items. I try not to install anything in /usr/local
# without homebrew doing it, feel comfortable just to get rid of all files.


function abort {
  echo "$1"
  exit 1
}

set -e

/usr/bin/which -s git || abort "brew install git first!"
test -d /usr/local/.git || abort "brew update first!"

brew cask uninstall clamxav
brew cask uninstall vlc
brew cask uninstall firefox
brew cask uninstall handbrake
brew cask uninstall makemkv
brew cask uninstall spotify
brew cask uninstall the-unarchiver
brew cask uninstall google-chrome

# Cleaning up home directory
rm -rf ~/.rbenv
rm -rf ~/.gem
rm -rf ~/.npm
rm -rf ~/.nmv

cd `brew --prefix`
git checkout master
git ls-files -z | pbcopy
rm -rf Cellar
bin/brew prune
pbpaste | xargs -0 rm
#rm -r Library/Homebrew Library/Aliases Library/Formula Library/Contributions 
#test -d Library/LinkedKegs && rm -r Library/LinkedKegs
#rmdir -p bin Library share/man/man1 2> /dev/null

rm -rf ~/Library/Caches/Homebrew
rm -rf ~/Library/Logs/Homebrew

# Cleaning up additional directories in /usr/local
rm -rf .git
rm -rf etc
rm -rf bin
rm -rf share
rm -rf var
rm -rf opt
rm -rf Library


sudo rm -rf /Library/Caches/Homebrew
