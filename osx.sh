#!/bin/sh

function dock_app_xml()
{
    local app="$@"
    echo "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${app}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Show the ~/Library folder
chflags nohidden ~/Library

# Finder
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 48" ~/Library/Preferences/com.apple.finder.plist

##
# Terminal
##

defaults write com.apple.terminal "Default Window Settings" Pro
defaults write com.apple.terminal "Startup Window Settings" Pro

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
    DLOC=$[$DLOC-1]

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