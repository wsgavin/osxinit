#!/bin/sh

brew install bash
brew install bash-completion2

echo
echo "Adding homebrew version of bash to /etc/shells..."

if ! grep -Fxq "/usr/local/bin/bash" /etc/shells ; then
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
fi

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
