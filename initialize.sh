#!/bin/sh

#
# Bash script to install Homebrew, applications and some minor configurations
# to utilize the new installed application.
#

set -e

# Variables set throughout the script(s).

unset account_password
unset sudo_password
#unset mysql_root_password
unset git_fullname
unset git_fullname_entered
unset git_email
unset git_email_entered
unset regex_email

sudo_ok() {

  printf %s "$(date) "

  if  sudo -n true; then
    echo "sudo good"
  fi

  printf "\n"
}

# A set of scripts to prepare for initialization.

. "init/banner.sh"

. "init/input.sh"

. "init/exports.sh"

. "init/sudo_keep_alive.sh"

. "init/bash_init.sh"

# Now we get brewing.
#
# If the install was one line or two I did not create a separate install file
# for it in the init directory.

. "init/homebrew.sh"

# Running again as homebrew invalidate sudo
#
# Invalidate sudo timestamp before exiting
# at_exit { Kernel.system "/usr/bin/sudo", "-k" }

. "init/sudo_keep_alive.sh"

sudo_ok

. "init/bash.sh"

. "init/sudo_keep_alive.sh"

sudo_ok

. "init/git.sh"

sudo_ok

. "init/nodejs.sh"

sudo_ok

. "init/vim.sh"

sudo_ok

. "init/ruby.sh"

sudo_ok

. "init/python.sh"

#sudo_ok
#
#. "init/mysql.sh"

sudo_ok

. "init/php.sh"

sudo_ok

# This file has all the simple brews...

. "init/brew_others.sh"

sudo_ok

# Now on to casks...

# TODO May no longer need to install cask separately.

. "init/homebrew_cask.sh"

sudo_ok

. "init/brew_cask_others.sh"

sudo_ok

# Installing java here as they are part of casks.

. "init/java.sh"

sudo_ok

brew cleanup
brew cask cleanup

. "osx.sh"

unset account_password
unset sudo_password
#unset mysql_root_password
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
