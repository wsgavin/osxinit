#!/bin/sh


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
