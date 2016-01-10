#!/bin/sh

#
# Bash script to install Homebrew, applications and some minor configurations
# to utilize the new installed application.
#

set -e

# Variables set throughout the script(s).

unset account_password
unset sudo_password
unset mysql_root_password
unset git_fullname
unset git_fullname_entered
unset git_email
unset git_email_entered
unset regex_email

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

. "init/bash.sh"

. "init/git.sh"

. "init/nodejs.sh"

. "init/vim.sh"

. "init/ruby.sh"

. "init/python.sh"

. "init/mysql.sh"

. "init/php.sh"

# This file has all the simple brews...

. "init/brew_others.sh"

# Now on to casks...

. "init/homebrew_cask.sh"

. "init/brew_cask_others.sh"

# Installing java here as they are part of casks.

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
