#!/bin/sh

# Ask for the administrator password upfront.
#echo "$sudo_password" | sudo -Sv

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
  #sudo -n true;
  echo "$sudo_password" | sudo -Sv
  sleep 60;
  kill -0 "$$" || exit;
done 2>/dev/null &
