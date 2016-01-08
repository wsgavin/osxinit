#!/bin/sh

#
# TODO: Find proper regex for OS X hostname.
#


sidebarlists_device_visibility()
{

  local name=$1
  local value=$2

  count="$(/usr/libexec/PlistBuddy -c "Print :systemitems:VolumesList" ~/Library/Preferences/com.apple.sidebarlists.plist | grep -ca "Dict")"
  count=$(( count - 1 ))

  # shellcheck disable=SC2039
  for (( i=0; i<=count; i++ )); do
    n="$(/usr/libexec/PlistBuddy -c "Print :systemitems:VolumesList:$i:Name" ~/Library/Preferences/com.apple.sidebarlists.plist 2>/dev/null)"

    if [[ $name =~ $n ]]; then
      /usr/libexec/PlistBuddy -c "Set :systemitems:VolumesList:$i:Visibility $value" ~/Library/Preferences/com.apple.sidebarlists.plist
    fi
  done
}

dock_app_xml()
{
    local app=$*
    echo "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${app}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}


S_HOSTNAME="$(hostname -s)"

s_entered_hostname=""
regex_hostname="^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"

echo
echo "The following script will configure some personal settings."
echo "Press Return to accept the defaults in brackets."
echo

echo "Configuring hostname..."
echo

while [ -z "$s_entered_hostname" ]
do

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Enter new hostname [$S_HOSTNAME]: " s_entered_hostname

  if [ -z "$s_entered_hostname" ]; then
    s_entered_hostname="$S_HOSTNAME"
  fi

  # shellcheck disable=SC2039 disable=SC2162
  read -p "Confirm hostname '$s_entered_hostname' [Y/n]: " yn

  case "$yn" in
    ""|[Yy])
      # shellcheck disable=SC2039
      if [[ "$s_entered_hostname" =~ $regex_hostname ]]; then
        S_HOSTNAME="$s_entered_hostname"
      else
        s_entered_hostname=""
      fi
      ;;
    *)
      s_entered_hostname=""
      ;;
  esac

  if [ -z "$s_entered_hostname" ]; then
    echo "Something is wrong, let's try again."
  fi

done

echo
echo "Completing git personal settings..."

##
# System
##

# Setting some hostname details
echo
echo "Setting hostname details..."
sudo scutil --set HostName musky
sudo scutil --set LocalHostName musky
sudo scutil --set ComputerName musky
sudo defaults write \
  /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName \
  musky

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Setting timezone.
sudo systemsetup -settimezone America/Chicago

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Show the ~/Library folder
chflags nohidden ~/Library

##
# Finder
##

/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist

defaults write com.apple.sidebarlists systemitems -dict-add ShowEjectables -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowHardDisks -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowRemovable -bool true
defaults write com.apple.sidebarlists systemitems -dict-add ShowServers -bool true
defaults write com.apple.finder AppleShowAllFiles -bool false

# Setting the visibility of Devices in the Finder Sidebar
sidebarlists_device_visibility "Computer" "AlwaysVisible"
sidebarlists_device_visibility "Macintosh HD" "AlwaysVisible"
sidebarlists_device_visibility "Network" "AlwaysVisible"

#/usr/libexec/PlistBuddy -c "Set :systemitems:VolumesList:0:Visibility AlwaysVisible" ~/Library/Preferences/com.apple.sidebarlists.plist
#/usr/libexec/PlistBuddy -c "Set :systemitems:VolumesList:1:Visibility AlwaysVisible" ~/Library/Preferences/com.apple.sidebarlists.plist


# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Opens new Finder window to $HOME
defaults write com.apple.finder NewWindowTarget PfHm

# Configuring the favorites.
./bin/mysides remove "All My Files"
./bin/mysides remove "iCloud"
./bin/mysides remove "Applications"
./bin/mysides add "$('whoami')" file:///"$HOME"

##
# Terminal
##

open terminal/Solarized\ Dark\ xterm-256color.terminal
echo "Sleeping 5 seconds to ensure new profile is available..."
sleep 5
echo "Setting Solarized Dark xterm-256color as default terminal"
defaults write com.apple.terminal "Default Window Settings" "Solarized Dark xterm-256color"
defaults write com.apple.terminal "Startup Window Settings" "Solarized Dark xterm-256color"

# Setting terminal to close after clean exit.
# TODO There should be a better way to do this.
/usr/libexec/PlistBuddy -c "Set \"Window Settings\":Pro:shellExitAction 1" \
    ~/Library/Preferences/com.apple.Terminal.plist

##
# Dock
##

# Set the default and magnification icon sizes
defaults write com.apple.dock magnification -bool false

# Setting dock icon size.
defaults write com.apple.dock tilesize -int 48

# Remove applications from the dock. The following code removes on the
# applications listed:
#
#     Safari
#     Mail
#     Contacts
#     Calendar
#     Notes
#     Reminders
#     Maps
#     Photos
#     Messages
#     FaceTime
#     Pages
#     Numbers
#     Keynote
#     iTunes
#     iBooks
#
# The following command will give an idea of what application are on the dock.
#
# defaults read com.apple.dock persistent-apps | grep label
#
# The following command will reset the dock to the set of default applications.
#
# defaults delete com.apple.dock; killall Dock
#
# TODO This was the only way I could find to do this, but there must be a
#      better way.
for APP in Safari Mail Contacts Calendar Notes Reminders Maps Photos \
    Messages FaceTime Pages Numbers Keynote iTunes iBooks;
do

    DLOC=$(defaults read com.apple.dock persistent-apps | \
        grep file-label | awk "/${APP}/  {printf NR}")
    DLOC=$((DLOC-1))

    if [ ${DLOC} -ge 0 ]
    then
        echo Removing ${APP} from dock...
        /usr/libexec/PlistBuddy -c "Delete persistent-apps:${DLOC}" \
            ~/Library/Preferences/com.apple.dock.plist
    fi

    unset DLOC

done

unset APP

# Add Chrome
defaults write com.apple.dock persistent-apps -array-add \
    "$(dock_app_xml '/opt/homebrew-cask/Caskroom/google-chrome/latest/Google Chrome.app')"

# Add Spotify
defaults write com.apple.dock persistent-apps -array-add \
    "$(dock_app_xml '/opt/homebrew-cask/Caskroom/spotify/latest/Spotify.app')"

# Add Terminal
defaults write com.apple.dock persistent-apps -array-add \
    "$(dock_app_xml '/Applications/Utilities/Terminal.app')"

# Restart Dock
killall cfprefsd
killall Dock
killAll Finder
