#!/bin/bash

if [ $# -ne 2 ]; then
  echo "$0 <decrypted filename> <encrypted filename>"
  exit 1
fi

openssl enc -aes-256-cbc -salt -in $1 -out $2
