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


cat <<EOF

                      .__       .__  __
   ____  _________  __|__| ____ |__|/  |_
  /  _ \/  ___/\  \/  /  |/    \|  \   __\\
 (  <_> )___ \  >    <|  |   |  \  ||  |
  \____/____  >/__/\_ \__|___|  /__||__|
            \/       \/       \/


** The osxinit repository and it's content are provided "as is" with NO
WARRANTY. Use at your own risk. **


The following script will install and configure an OS X system. configurations
and installations are purely opinionated.

Many thanks to https://mths.be/dotfiles

EOF



git_email="$(/usr/libexec/PlistBuddy -c "Print" \
  ~/Library/Preferences/com.apple.ids.service.com.apple.madrid.plist | \
  grep LoginAs | sed 's/.*LoginAs = //' 2>/dev/null)"

git_fullname="$(osascript -e 'long user name of (system info)')"

regex_email="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# Grabbing password for future use where required.

stty -echo
echo
echo "Password entered will be used when required. Can be changed lager."
echo
printf "Enter password: "
read -r sudo_password
account_password=sudo_password
mysql_root_password=sudo_password
stty echo


echo
echo "Configuring git settings..."
echo

while [ -z "$get_fullname_entered" ]
do

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Enter full name [$git_fullname]: " get_fullname_entered

  if [ -z "$get_fullname_entered" ]; then
    get_fullname_entered="$git_fullname"
  fi

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Confirm full name '$get_fullname_entered' [Y/n]: " yn

  case "$yn" in
    ""|[Yy])
        git_fullname="$get_fullname_entered"
      ;;
    *)
      get_fullname_entered=""
      ;;
  esac

  if [ -z "$get_fullname_entered" ]; then
    echo "Something is wrong, let's try again."
  fi

done

# Ask for valid email address for git.

while [ -z "$git_email_entered" ]
do

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Enter new email address [$git_email]: " git_email_entered

  if [ -z "$git_email_entered" ]; then
    git_email_entered="$git_email"
  fi

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Confirm email address '$git_email_entered' [Y/n]: " yn

  case "$yn" in
    ""|[Yy])
      # shellcheck disable=SC2039
      if [[ "$git_email_entered" =~ $regex_email ]]; then
        git_email="$git_email_entered"
      else
        git_email_entered=""
      fi
      ;;
    *)
      git_email_entered=""
      ;;
  esac

  if [ -z "$git_email_entered" ]; then
    echo "Something is wrong, let's try again."
  fi

done

echo
echo "done."

# Setting up the PATH for this script to work.

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/php56/bin:$PATH"







# Ask for the administrator password upfront.
echo "$sudo_password" | sudo -Sv

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# TODO
#
# Added this part here because it seems that something after this point resets
# the sudo timeout "I think."
#

echo
echo "Adding homebrew version of bash to /etc/shells..."

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi

# Install Homebrew http://brew.sh
#
# Redirecting STDIN to /dev/null so one does not have to press Return to
# continue.

ruby -e "$(curl \
  -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  </dev/null

brew update
brew upgrade
brew doctor

brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php

brew install bash
brew install bash-completion2

# TODO Test alternatives to expect.
#
# Account password required here vs. sudo. Reason expect is used.

echo
echo "Setting user shell to /usr/local/bin/bash..."

expect<<EOF
spawn chsh -s /usr/local/bin/bash
expect "Password"
send "$account_password\r"
expect eof
EOF

echo "done."

brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils
brew install findutils --with-default-names
brew install gnu-sed --with-default-names
brew install ack
brew install homebrew/dupes/grep --with-default-names
brew install tmux
brew install ffmpeg --with-faac
brew install nmap
brew install wget

brew install git

echo
printf "Configuring git..."

git config --global user.name "$git_fullname"
git config --global user.email "$git_email"
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global color.ui auto
git config --global push.default simple
git config --global format.pretty "%h - %an, %ar : %s"

echo "done."


brew install nvm


echo
echo "Initializing nvm..."

mkdir -p ~/.nvm
cp "$(brew --prefix nvm)/nvm-exec" ~/.nvm/
export NVM_DIR=~/.nvm
# shellcheck source=/dev/null
source "$(brew --prefix nvm)/nvm.sh"

echo "done."

# Installing nodejs with nvm

echo
echo "Installing nodejs..."

nvm install node
# FIXME Something is happening where after the install the script just stops...
#nvm alias default node
#npm update --global

echo "done."

# Install node modules.

echo
echo Installing node modules...

npm install --global \
  yo \
  grunt-cli \
  bower \

npm cache clean

echo "done."




brew install vim --override-system-vi

echo
printf "Initializing vim..."

mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.vim/backups"
mkdir -p "$HOME/.vim/swaps"
mkdir -p "$HOME/.vim/undo"
mkdir -p "$HOME/.vim/autoload"
mkdir -p "$HOME/.vim/bundle"

echo "done."

# Install pathogen
curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

# Installing some plugins
git clone git://github.com/tpope/vim-sensible.git \
  "$HOME/.vim/bundle/vim-sensible"
git clone git://github.com/altercation/vim-colors-solarized.git \
  "$HOME/.vim/bundle/vim-colors-solarized"

echo








brew install rbenv ruby-build



echo
echo "Installing Ruby..."

# Found this sed command to find the latest version of ruby from rbenv.
# Shellcheck does not like the $ inside the single quotes. I'm not a sed expert
# and not sure what to do to resolve the check. Ignoring for now as it works.
#
# shellcheck disable=SC2016
RUBY_VER="$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}' | tr -d '[:space:]')"

rbenv install "$RUBY_VER"
rbenv global "$RUBY_VER"

# Initialize Ruby environment so gems are installed in the correct location.

echo
echo "Initializing rbenv..."
eval "$(/usr/local/bin/rbenv init -)"
echo
echo "Installing compass"

gem install compass
rbenv rehash

echo "done."





brew install ctags
brew install shellcheck
brew install python


echo
echo "Initializing python..."

mkdir -p "$HOME/Library/Python/2.7/lib/python/site-packages"
echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> \
  "$HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth"

mkdir "$HOME/.virtualenvs"
pip install --upgrade --no-use-wheel pip setuptools
#pip install --upgrade setuptools
pip install virtualenv
pip install virtualenvwrapper

echo "done."

# MySQL
brew install mysql

# mysql_secure_installation automated
mysql.server start

expect<<EOF
set timeout 2
spawn mysql_secure_installation
expect "Press y|Y for Yes, any other key for No:"
send "n\r"
expect "New Password:"
send_user "After New"
send "$mysql_root_password\r"
expect "Re-enter new password:"
send "$mysql_root_password\r"
expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"
expect eof
EOF

mysql.server stop

# PHP
brew install zlib
brew install homebrew/php/php56 --with-pear
brew install php56-mcrypt
brew install composer




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


#####
# Installing JAVA & Utilities
#####

# Downloading Apple's version of Java.

echo
echo "Installing Apple's version of Java."
wget -O ~/Downloads/javaforosx.dmg \
  https://support.apple.com/downloads/DL1572/en_US/javaforosx.dmg
hdiutil attach ~/Downloads/javaforosx.dmg
sudo installer -package /Volumes/Java\ for\ OS\ X\ 2015-001/JavaForOSX.pkg -target /
hdiutil detach /Volumes/Java\ for\ OS\ X\ 2015-001
rm "$HOME/Downloads/javaforosx.dmg"

brew cask install java
brew cask install java7
brew install jenv

echo
echo "Initializing jenv..."

eval "$(jenv init -)"

# Loops through all the Java installs and adds them to jenv.
for f in /Library/Java/JavaVirtualMachines/*
do
    jenv add "$f/Contents/Home"
done

jenv rehash

echo "done."



brew cleanup
brew cask cleanup





echo
printf "Initializing home directory with dotfiles..."
cp -r home/.[!.]* ~/
echo "done."

echo
echo "Initialization complete."
echo

unset account_password
unset sudo_password
unset mysql_root_password

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
