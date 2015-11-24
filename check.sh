#!/bin/sh


# Setting some color constants
COLOR_GREEN="\x1b[0;32m"
COLOR_RED="\x1b[0;31m"
COLOR_RESET="\x1b[0m"

# Setting some escaped characters
CHAR_CHECKMARK="\xE2\x9C\x93"
CHAR_XMARK="\xE2\x9C\x97"

# Host used to test Internet connection
PING_HOST="raw.githubusercontent.com"

abort() {
  echo "$1"
  exit 1
}

echo
echo "Checking a few things to make sure we are good to go..."
echo

# Checking for an Internet connection
if /sbin/ping -s1 -t4 -o ${PING_HOST} >/dev/null 2>&1
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} We have an Internet connection."
  else
    abort "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} We do not have an Internet connection."
fi

# Check if the current account is in the admin group
if groups | grep -w -q admin 2>&1
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} You are an admin."
  else
    abort "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} You are not an admin."
fi

# Determine if the Xcode command line tools installed.

# Checking to make sure xcode-command line tools are installed.
XCODE_SELECT=$(xcode-select -p 2>&1);

#if [[ $XCODE_SELECT == "/Library/Developer/CommandLineTools" || \
#  $XCODE_SELECT == "/Applications/Xcode.app/Contents/Developer" ]]

if [ "$XCODE_SELECT" = '/Library/Developer/CommandLineTools' ] || \
    [ "$XCODE_SELECT" = '/Applications/Xcode.app/Contents/Developer' ]
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} Xcode command line tools installed."

  else
    echo "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} Xcode command line tools not installed."
    abort "Please run '$ xcode-select --install'"
fi

# Checking for git
if command -v /usr/bin/git >/dev/null 2>&1
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} git appears to be available."
  else
    abort "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} Xcode command line tools git not found!"
fi

echo
echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} All good to go..."
echo
echo "Initial setup of the system is next, run the following commands:"
echo
echo "$ git clone https://github.com/wsgavin/osxinit.git"
echo "$ cd osxinit"
echo "$ ./initialize.sh"
echo

exit 0
