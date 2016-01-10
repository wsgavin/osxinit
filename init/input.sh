#!/bin/sh

git_email="$(/usr/libexec/PlistBuddy -c "Print" \
  ~/Library/Preferences/com.apple.ids.service.com.apple.madrid.plist | \
  grep LoginAs | sed 's/.*LoginAs = //' 2>/dev/null)"

git_fullname="$(osascript -e 'long user name of (system info)')"

regex_email="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# Grabbing password for future use where required.

stty -echo
echo
echo "Password entered will be used when required. Can be changed lager."
echo
printf "Enter password: "
read -r sudo_password
stty echo


account_password=sudo_password
mysql_root_password=sudo_password


export sudo_password
export account_password
export mysql_root_password

echo
echo "Configuring git settings..."
echo

while [ -z "$get_fullname_entered" ]
do

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Enter full name [$git_fullname]: " get_fullname_entered

  if [ -z "$get_fullname_entered" ]; then
    get_fullname_entered="$git_fullname"
  fi

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Confirm full name '$get_fullname_entered' [Y/n]: " yn

  case "$yn" in
    ""|[Yy])
        git_fullname="$get_fullname_entered"
      ;;
    *)
      get_fullname_entered=""
      ;;
  esac

  if [ -z "$get_fullname_entered" ]; then
    echo "Something is wrong, let's try again."
  fi

done

# Ask for valid email address for git.

while [ -z "$git_email_entered" ]
do

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Enter new email address [$git_email]: " git_email_entered

  if [ -z "$git_email_entered" ]; then
    git_email_entered="$git_email"
  fi

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Confirm email address '$git_email_entered' [Y/n]: " yn

  case "$yn" in
    ""|[Yy])
      # shellcheck disable=SC2039
      if [[ "$git_email_entered" =~ $regex_email ]]; then
        git_email="$git_email_entered"
      else
        git_email_entered=""
      fi
      ;;
    *)
      git_email_entered=""
      ;;
  esac

  if [ -z "$git_email_entered" ]; then
    echo "Something is wrong, let's try again."
  fi

done

echo
echo "done."
