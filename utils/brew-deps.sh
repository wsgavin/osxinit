#!/usr/local/bin/bash

brew list | while read cask; do echo -n -e "\e[1;34m$cask ->\e[0m"; brew deps $cask | awk '{printf(" %s ", $0)}'; echo ""; done
