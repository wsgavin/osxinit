#!/bin/sh

set -x

brew install bash
brew install bash-completion2


# TODO
#
# I Think this is fixed...
#
# Added this part here because it seems that something after this point resets
# the sudo timeout "I think."
#

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

echo "$account_password"

expect<<EOF
spawn chsh -s /usr/local/bin/bash
expect "Password"
send "$account_password\r"
expect eof
EOF

echo "done."

set +x
