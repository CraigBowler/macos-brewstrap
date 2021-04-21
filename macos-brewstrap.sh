#!/usr/bin/env bash
#
# Bash script for installing Homebrew and any packages and casks on a fresh install of macOS
#
# The following apps don't have a cask and need to be installed manually:
#
# - Spark (App Store)
# - SiteSucker (https://ricks-apps.com/osx/sitesucker/)

printf '\e[92mStarting macOS Brewstrap...'

# If Homebrew is not installed on the system, it will be installed here
if test ! $(which brew); then
   printf '\n\n\e[33mHomebrew not found. \e[0mInstalling Homebrew...'
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf '\n\n\e[0mHomebrew found. Continuing...'
fi

# Update homebrew packages
printf '\nInitiating Homebrew update...\n'
brew update

PACKAGES=(
   composer
   node
)

printf '\nInstalling packages...\n'
brew install ${PACKAGES[@]}

printf '\n\nRemoving out of date packages...\n'
brew cleanup

printf '\n\nInstalling cask...\n'
brew install cask

CASKS=(
   1password
   atom
   docker
   firefox
   google-chrome
   macs-fan-control
   mamp
   ngrok
   postman
   screaming-frog-seo-spider
   sequel-pro
   slack
   sourcetree
   transmit
   zoomus
)

printf '\n\nInstalling cask apps...\n'
brew install --cask ${CASKS[@]}

printf '\n\nUpdating npm...\n'
npm install -g npm

printf '\n\nInstalling global npm packages...\n'
npm install -g sass

printf '\n\nConfiguring macOS settings...'

#Finder Settings
defaults write com.apple.finder AppleShowAllFiles -string "YES" # Show hidden (.) files be default

# Dock Settings
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock tilesize -int 50
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock autohide-delay -float 0

# Mouse & Trackpad Settings
defaults write -g com.apple.mouse.scaling -int 3
defaults write -g com.apple.trackpad.scaling -float 0.875
defaults write -g com.apple.trackpad.scrolling -float 0.4412
defaults write -g com.apple.trackpad.forceClick -float 0.4412

# System Preferences > Mission Control > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

sleep 3

printf '\n\n\e[1;92mBrewstrap complete! \e[0m(Note that some of these changes require a logout/restart to take effect)\n\n'
