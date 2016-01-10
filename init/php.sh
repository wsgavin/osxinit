#!/bin/sh
brew tap homebrew/homebrew-php
brew install zlib
brew install homebrew/php/php56 --with-pear
brew install php56-mcrypt
brew install composer
