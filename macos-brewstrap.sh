#!/usr/bin/env bash
#
# Bash script for installing Homebrew and any packages and casks on a fresh install of macOS
#
# The following apps don't have a cask and need to be installed manually:
#
# - Spark (App Store)
# - SiteSucker (https://ricks-apps.com/osx/sitesucker/)

echo "Starting Brewstrap"

# If Homebrew is not installed on the system, it will be installed here
if test ! $(which brew); then
   echo "Homebrew not found. Installing Homebrew..."
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew packages
brew update

PACKAGES=(
   composer
   node
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Removing out of date packages..."
brew cleanup

echo "Installing cask..."
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

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Updating npm..."
npm install -g npm

echo "Installing global npm packages..."
npm install -g sass

echo "Brewstrap complete"
