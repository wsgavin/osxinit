#!/bin/sh

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
