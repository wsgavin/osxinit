#!/bin/bash

if [ $# -ne 2 ]; then
  echo "$0 <encrypted file> <decrypted file>"
  exit 1
fi

openssl enc -aes-256-cbc -d -in $1 -out $2
