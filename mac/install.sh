#!/usr/bin/env bash
NORMAL_COLOR="\033[0m"
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
BLUE_COLOR="\033[0;34m"

function normal_color() { echo -e "${NORMAL_COLOR}\c" ; }
function red_color() { echo -e "${RED_COLOR}\c" ; }
function green_color() { echo -e "${GREEN_COLOR}\c" ; }
function blue_color() { echo -e "${BLUE_COLOR}\c" ; }

set -e
trap on_sigterm SIGKILL SIGTERM
brewInstallUrl="https://raw.githubusercontent.com/Homebrew/install/master/install"

green_color

echo "  __  __             ____   _____ "
echo " |  \/  |           / __ \ / ____|"
echo " | \  / | ____  ___| |  | | (___  "
echo " | |\/| |/ _  |/ __| |  | |\___ \ "
echo " | |  | | (_| | (__| |__| |____) |"
echo " |_|  |_|\____|\___|\____/|_____/ "
echo "     _____      _               "
echo "    / ____|    | |              "
echo "   | (___   ___| |_ _   _ ____  "
echo "    \___ \ / _ | __| | | |  _ \ "
echo "    ____) |  __| |_| |_| | |_) |"
echo "   |_____/ \___|\__|\____|  __/ "
echo "                         | |    "
echo "                         |_|    "
echo ""

if ! [ $(xcode-select -p > /dev/null) ]; then
    blue_color
    echo "Installing XCode Command Line Tools..."
    echo "Please wait until XCode Command Line Tools are installed before continuing"
    xcode-select --install
    normal_color
    echo ""
    echo "Wait till XCode Command Line Tools have finished installing before continuing."
    echo ""
    blue_color
    read -p "Press any key to continue..." -n 1 answer
else
    green_color
    echo "XCode Command Line Tools are already installed..."
fi

echo ""
normal_color
sleep 1

if ! [ $(which brew) ]; then
    blue_color
    echo "Installing Homebrew..."

    ruby -e "$(curl -fsSL ${brewInstallUrl})"
    brew update
    brew upgrade

    echo "Homebrew finished installing!"
else
    green_color
    echo "Homebrew is already installed..."
fi
echo ""
normal_color
sleep 1

#Install Homebrew Cask Applications
blue_color
echo "Installing Homebrew/Caskroom Applications for Dev Environment..."
normal_color
echo ""

brew tap caskroom/versions
brew update
brew upgrade
brew cask install iterm2

#brew cask install dotnet
#brew cask install dotnet-sdk
brew cask install java8
#brew cask install java9
#brew cask install java
brew install jenv
brew install node
brew install python

brew install git
#brew cask install perforce
brew install ant
brew install maven
brew install gradle
#brew cask install docker
#brew cask install virtualbox
#brew install terraform

brew cask install google-chrome
#brew cask install firefox-developer-edition

brew cask install visual-studio-code
#brew cask install sublime-text
#brew cask install atom

#brew cask install sql-operations-studio
#brew cask install mysqlworkbench
#brew cask install dbeaver-community

#brew cask install intellij-idea-ce
#brew cask install eclipse-ide

#brew install awscli
#brew install azure-cli
#brew cask install google-cloud-sdk

#brew cask install postman
#brew cask install macs-fan-control
#brew cask install cinch
#brew cask install microsoft-office
#brew cask install adobe-acrobat-reader

javaParentPath=/Library/Java/JavaVirtualMachines/
cd $javaParentPath
java8Dir=`ls -d *jdk1.8.*/`
#java10Dir=`ls -d *jdk1.10.*/`
cd ~
java8Path="${javaParentPath}${java8Dir}Contents/Home/"
#java10Path="${javaParentPath}${java10Dir}Contents/Home/"

jenv init
jenv add $java8Path
#jenv add $java10Path

echo "" >> ~/.bash_profile
echo 'if which jenv > /dev/null; then eval "$(jenv init -)"; fi' >> ~/.bash_profile
echo 'export JAVA_HOME="${java8Path}"' >> ~/.bash_profile
echo 'export JDK_HOME="${java8Path}"' >> ~/.bash_profile
echo 'export JAVA18_HOME="${java8Path}"' >> ~/.bash_profile
