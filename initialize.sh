#!/bin/sh

#
# Bash script to install Homebrew, applications and some minor configurations
# to utilize the new installed application.
#

set -e

unset account_password
unset sudo_password
unset mysql_root_password
unset git_fullname
unset git_fullname_entered
unset git_email
unset git_email_entered
unset regex_email




. "init/banner.sh"
. "init/input.sh"
. "init/exports.sh"
. "init/sudo_keep_alive.sh"




# # Ask for the administrator password upfront.
# echo "$sudo_password" | sudo -Sv

# # Keep-alive: update existing `sudo` time stamp until the script has finished.
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &




. "init/bash_init.sh"
. "init/homebrew.sh"

# TODO do I need this?
brew tap homebrew/versions

. "init/bash.sh"

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

. "init/git.sh"
. "init/nodejs.sh"
. "init/vim.sh"
. "init/ruby.sh"
. "init/python.sh"
. "init/mysql.sh"
. "init/php.sh"

# Install cask...

brew tap caskroom/versions
brew install caskroom/cask/brew-cask

brew cask install adobe-reader
brew cask install arduino
brew cask install cleanmymac
brew cask install dropbox
brew cask install google-chrome
brew cask install handbrake
brew cask install java
brew cask install java7
brew cask install makemkv
brew cask install parallels-desktop
brew cask install real-vnc
brew cask install silverlight
brew cask install spotify
brew cask install sublime-text3
brew cask install the-unarchiver
brew cask install transmission
brew cask install vlc
brew cask install sophos-anti-virus-home-edition
sudo chown -R "$(whoami)":admin /usr/local/bin
sudo chown -R "$(whoami)":admin /usr/local/share
brew cask install malwarebytes-anti-malware

#brew cask install 1password
#brew cask install microsoft-office
#brew cask install crashplan
#brew cask install gopro-studio
#brew cask install minecraft
#brew cask install skype
#brew cask install snagit

. "init/java.sh"

brew cleanup
brew cask cleanup

unset account_password
unset sudo_password
unset mysql_root_password
unset git_fullname
unset git_fullname_entered
unset git_email
unset git_email_entered
unset regex_email

# This is done to avoid the use of /usr/local/bin/find as it is not compatible
# with Apples bash sessions.
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

exit 0

# Non brew cask installs
#
# Western Digital Disk Utilities
# Brother P-Touch software (label maker)
#
# Apps purchased through App Store
#
# Day One
# Gemini
#
