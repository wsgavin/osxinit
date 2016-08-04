#!/bin/sh

plist=$1
search=$2
key=$3

count="$(/usr/libexec/PlistBuddy -c "Print $search" "$plist"| grep -ca "Dict")"

count=$(( count - 1 ))

# shellcheck disable=SC2039
for (( i=0; i<=count; i++ )); do
  name="$(/usr/libexec/PlistBuddy -c "Print $search:$i:$key" "$plist" 2>null)"

  if [[ "Computer" =~ $name ]]; then
    echo "yes"
  fi
done
