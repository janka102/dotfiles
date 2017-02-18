#!/usr/bin/env bash

########################################################################
# Sets up settings for the system and various apps
# Some from https://github.com/mathiasbynens/dotfiles/blob/master/.macos
########################################################################

echo '=============================================='
echo '=           Setting macOS defaults           ='
echo '=============================================='
echo ''

#========
# General
#========

# Set computer name
echo 'Setting computer name, requires sudo:'
sudo scutil --set ComputerName 'rockbook'
sudo scutil --set HostName 'rockbook'
sudo scutil --set LocalHostName 'rockbook'

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=' '

# Reduce transparency in the menu bar and elsewhere
defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable the over-the-top focus ring animation
defaults write -g NSUseAnimatedFocusRing -bool false

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Change double clicking the title bar from minimize to maximize
defaults write -g AppleActionOnDoubleClick -string 'Maximize'
defaults write -g AppleMiniaturizeOnDoubleClick -bool false

# Always show the scroll bar
defaults write -g AppleShowScrollBars -string 'Always'

# Default to save to Disk, vs iCloud
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Require password 1 second after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 1

# Disable the network Captive Portal
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Disable Creation of Metadata Files on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Creation of Metadata Files on USB Volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable Remote Control Infrared Receiver
echo ''
echo 'Disabling Remote Control Infrared Receiver, requires sudo:'
sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

# Sets Screen Saver
defaults -currentHost write com.apple.ScreenSaverPhotoChooser CustomFolderDict -dict identifier "${HOME}/Documents/Google Drive/Wallpapers" name 'Wallpapers'
defaults -currentHost write com.apple.ScreenSaverPhotoChooser SelectedFolderPath -string "${HOME}/Documents/Google Drive/Wallpapers"
defaults -currentHost write com.apple.ScreenSaverPhotoChooser SelectedSource -int 4

defaults -currentHost write com.apple.ScreenSaver.iLifeSlideShows styleKey -string 'ShiftingTiles'

defaults -currentHost write com.apple.screensaver showClock -bool true
defaults -currentHost write com.apple.screensaver moduleDict -dict-add moduleName 'iLifeSlideshows'
defaults -currentHost write com.apple.screensaver moduleDict -dict-add path '/System/Library/Frameworks/ScreenSaver.framework/Resources/iLifeSlideshows.saver'

#=========
# Firewall
#=========

echo ''
echo 'Setting up Firewall, requires sudo:'

# Enable Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
# Enable Firewall logging
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
# Disable built-in and downloaded code-signed apps by default
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

#==========================
# Keyboard, Trackpad, input
#==========================

# Disable natural scroll direction
defaults write -g 'com.apple.swipescrolldirection' -bool false

# Set faster key repeat
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable autocorrect and key substitutions
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticTextCompletionEnabled -bool false

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Double tap and drag, with drag lock
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false

# 3 finger side-to-side "Swipe between full-screen apps"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2

# 3 finger up-and-down "Mission Control" & "App Exposé"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2

# Disable 2 finger "Notification Center"
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0

# Disable 3 finger "Look up & data detectors"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0

# Change "Pinch with thumb and three fingers" to Mission Control instead of Launchpad
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showDesktopGestureEnabled -bool true

# Disable Rubberband Scrolling
defaults write -g NSScrollViewRubberbanding -bool false

#=====
# Dock
#=====

# Auto hide/show
defaults write com.apple.dock autohide -bool true

# Set icon size
defaults write com.apple.dock tilesize -int 45

# Enable highlight hover effect for the kind view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# Don't rearrange Spaces based on recently used
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Lower the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.15

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

#=======
# Finder
#=======

# Show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Show all file extensions in Finder (.app, etc)
defaults write -g AppleShowAllExtensions -bool true

# Default search is Current Folder; SCev => This Mac
defaults write com.apple.Finder FXDefaultSearchScope -string 'SCcf'

# Default view is Columns; Nlsv => List; icnv => Icons; Flwv => Cover Flow
defaults write com.apple.Finder FXPreferredViewStyle -string 'clmv'

# New windows open to Home Folder; PfVo => Main volume; PfAF => All My Files; PfCm => Computer
defaults write com.apple.Finder NewWindowTarget -string 'PfHm'
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Show everything on Desktop
defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.Finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.Finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool true

# Enable SortBy > Kind for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy kind' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:IconViewSettings:arrangeBy kind' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy kind' ~/Library/Preferences/com.apple.finder.plist

# Remove tags and pathbar from Finder
defaults write com.apple.Finder ShowPathbar -bool false
defaults write com.apple.Finder ShowRecentTags -bool false

# Enable Preview pane, sidebar, statusbar, and tab view
defaults write com.apple.Finder ShowPreviewPane -bool true
defaults write com.apple.Finder ShowSidebar -bool true
defaults write com.apple.Finder ShowStatusBar -bool true
defaults write com.apple.Finder ShowTabView -bool true

# Show folders on top
defaults write com.apple.Finder '_FXSortFoldersFirst' -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

#=======
# Safari
#=======

defaults write com.apple.Safari AlwaysShowTabBar -bool true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari BlockStoragePolicy -int 3
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 1
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# AutoFill Privacy
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Search Privacy
defaults write com.apple.Safari SuppressSearchSuggestions -bool yes
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false
defaults write com.apple.Safari PreloadTopHit -bool false

#==========
# Spotlight
#==========

echo ''
echo 'Opening System Preferences...'
echo 'Please go to Spotlight and then close'
open -W -a 'System Preferences'

# Remove options for Spotlight to lookup things on Internet
new_spotlight=$(defaults read com.apple.Spotlight orderedItems)
new_spotlight=$(echo "$new_spotlight" | tr -d '\040\012')
new_spotlight=$(echo "$new_spotlight" | sed -E 's/(enabled=)1(;name="(MENU_SPOTLIGHT_SUGGESTIONS|MENU_CONVERSION|MENU_DEFINITION)")/\10\2/g')
defaults write com.apple.Spotlight orderedItems "$new_spotlight"
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool false

#===========
# Other apps
#===========

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

echo ''
echo 'Done. Please restart the computer.'
