#!/bin/bash

# Install script for nodejs.
#
# Modified from https://gist.github.com/nicerobot/2697848

(( ${#} > 0 )) || {
  echo 'DISCLAIMER: USE THIS SCRIPT AT YOUR OWN RISK!'
  echo 'THE AUTHOR TAKES NO RESPONSIBILITY FOR THE RESULTS OF THIS SCRIPT.'
  echo "Disclaimer aside, this worked for the author, for what that's worth."
  echo 'Press Control-C to quit now.'
  read
  echo 'Re-running the script with sudo.'
  echo 'You may be prompted for a password.'
  sudo ${0} sudo
  exit $?
}
# This will need to be executed as an Admin (maybe just use sudo).

# Verify the bom exists, otherwise don't do anything
[ -e /var/db/receipts/org.nodejs.pkg.bom ] || {
  echo 'Nothing to do.'
  exit 0
}

# Loop through all the files in the bom.
lsbom -f -l -s -pf /var/db/receipts/org.nodejs.pkg.bom \
| while read i; do
  # Remove each file listed in the bom.
  rm /usr/local/${i}
done

# Remove directories related to node.js.
rm -rf /usr/local/lib/node \
  /usr/local/lib/node_modules \
  /var/db/receipts/org.nodejs.* \
  ${HOME}/.npm

# Determine the latest version of nodejs.
latest=$(curl -silent http://nodejs.org/dist/latest/ | \
  grep -o 'node\-v[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.pkg' | \
  head -1)

# Download latest version of nodejs.
curl -O  http://nodejs.org/dist/latest/$latest

# Install nodejs
sudo installer -pkg $latest -target /

# From time to time I run into permisions that seem to be impacted by the
# installation. This is not the first time  you will see this.
sudo chown -R warren:wheel /usr/local
echo node `node --version`
echo npm `npm --version`


# Updating npm has caused me issues, disabling for now but leaving for
# reference.
#
# Updating npm (not modules)
# Updating npm seems to cause issues, so I've left this out for now.
#npm update npm -g
#npm cache clean
#
# Update npm global modules installed
# Run into issues where there are errors if the cache is not cleaned.
#npm cache clean
#npm update -g
#sudo chown -R warren:wheel /usr/local

# Install angularjs
npm cache clean
npm install -g yo


# Install generator-angular-fullstack
npm cache clean
npm install -g generator-angular-fullstack

# Cleanup
sudo chown -R warren:wheel /usr/local
npm cache clean

exit 0
