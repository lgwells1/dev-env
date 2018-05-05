#!/usr/bin/env bash

set -e
trap on_sigterm SIGKILL SIGTERM

brewInstallUrl="https://raw.githubusercontent.com/Homebrew/install/master/install"

if ! [ $(xcode-select -p) ]; then
    echo "Installing XCode Command Line Tools..."
    echo "Please wait until XCode Command Line Tools are installed before continuing"
    xcode-select --install
    read -p "Press any key to continue..." -n 1 answer
else
    echo "XCode Command Line Tools are already installed..."
fi

sleep 1

if ! [ $(which brew) ]; then

    echo "Installing Homebrew..."

    ruby -e "$(curl -fsSL ${brewInstallUrl})"
    brew update
    brew upgrade
    read -p "Press any key to continue..." -n 1 answer

    echo "Homebrew finished installing!"
else
    echo "Homebrew is already installed..."
fi

sleep 1

#Install Homebrew Cask Applications
brew cask install iterm2

brew cask install dotnet-sdk
brew cask install java8

brew install git
brew cask install perforce
brew install ant
brew install maven
brew install gradle
#brew cask install docker
#brew cask install virtualbox
brew install terraform

brew cask install google-chrome
brew cask install firefox-developer-edition

brew cask install visual-studio-code
brew cask install sublime-text
brew cask install atom

#brew cask install sql-operations-studio
#brew cask install mysqlworkbench
#brew cask install dbeaver-community

#brew cask install intellij-idea-ce
#brew cask install eclipse-ide

brew install awscli
brew install azure-cli
brew cask install google-cloud-sdk

brew cask install postman
brew cask install macs-fan-control
brew cask install cinch
#brew cask install microsoft-office
#brew cask install adobe-acrobat-reader
