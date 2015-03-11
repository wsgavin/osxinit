#!/bin/sh

COLOR_GREEN="\x1b[0;32m"
COLOR_RED="\x1b[0;31m"
COLOR_RESET="\x1b[0m"

CHAR_CHECKMARK="\xE2\x9C\x93"
CHAR_XMARK="\xE2\x9C\x97"

PING_HOST="raw.githubusercontent.com"
#PING_HOST="madeup.di.namemadszxcv.com"

function abort {
  echo "$1"
  exit 1
}

set -e

echo
echo "Checking a few things to make sure we are good to go..."
echo


if /sbin/ping -s1 -t4 -o ${PING_HOST} &> /dev/null
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} We have an Internet connection."
  else
    abort "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} We do not have an Internet connection."
fi

# Determine if the Xcode command line tools installed.

XCODE_SELECT=$(xcode-select -p 2>&1);

if [[ $XCODE_SELECT == "/Library/Developer/CommandLineTools" || \
  $XCODE_SELECT == "/Applications/Xcode.app/Contents/Developer" ]]
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} Xcode command line tools installed."
    
  else
    echo "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} Xcode command line tools not installed."
    abort "Please run xcode-select --install"
fi

if command -v /usr/bin/git >/dev/null 2>&1
  then
    echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} git appears to be available."
  else
    abort "${COLOR_RED}${CHAR_XMARK}${COLOR_RESET} Xcode command line tools git not found!"
fi 

echo
echo "${COLOR_GREEN}${CHAR_CHECKMARK}${COLOR_RESET} All good to go..."
echo

exit 0