#!/bin/sh

# MAKE SURE YOU ARE HAPPY WITH WHAT IT DOES FIRST! THERE IS NO WARRANTY!
#
# ASSUMPTION /usr/local & /opt can be fully deleted.


function abort {
  echo "$1"
  exit 1
}

set -e

/usr/bin/which -s brew || abort "No homebrew installed!"

brew cask uninstall clamxav
brew cask uninstall vlc
brew cask uninstall firefox
brew cask uninstall handbrake
brew cask uninstall makemkv
brew cask uninstall spotify
brew cask uninstall the-unarchiver
brew cask uninstall google-chrome
#brew cask uninstall parallels-desktop
brew cask uninstall mailbox
brew cask uninstall silverlight
brew cask uninstall gopro-studio
brew cask uninstall real-vnc
#brew cask uninstall cleanmymac
#brew cask uninstall snagit
brew cask uninstall dropbox
brew cask uninstall crashplan
#brew cask uninstall sublime-text
brew cask uninstall transmission
#brew cask uninstall minecraft
#brew cask uninstall 

# Cleaning up home directory
rm -rf ~/.cache
rm -rf ~/.local
rm -rf ~/.subversion
rm -rf ~/.rbenv
rm -rf ~/.gem
rm -rf ~/.npm
rm -rf ~/.nmv
rm -rf ~/Library/Caches/Homebrew
rm -rf ~/Library/Logs/Homebrew

#cd `brew --prefix`
#git checkout master
#git ls-files -z | pbcopy
#rm -rf Cellar
#bin/brew prune
#pbpaste | xargs -0 rm
#rm -r Library/Homebrew Library/Aliases Library/Formula Library/Contributions 
#test -d Library/LinkedKegs && rm -r Library/LinkedKegs
#rmdir -p bin Library share/man/man1 2> /dev/null



# Cleaning up additional directories in /usr/local
#rm -rf /usr/local/.git
#rm -rf /usr/local/etc
#rm -rf /usr/local/bin
#rm -rf /usr/local/share
#rm -rf /usr/local/var
#rm -rf /usr/local/opt
#rm -rf /usr/local/Library

sudo rm -rf /usr/local
sudo rm -rf /Library/Caches/Homebrew
sudo rm -rf /opt
