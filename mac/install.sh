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
    echo ""
    echo "Installing XCode Command Line Tools..."
    echo "Please wait until XCode Command Line Tools are installed before continuing"
    xcode-select --install
    red_color
    echo ""
    echo "Wait till XCode Command Line Tools have finished installing before continuing!"
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
brew cask install powershell

brew cask install dotnet
brew cask install dotnet-sdk
brew cask install java8
#brew cask install java9
brew cask install java
brew install jenv
brew install node
brew install python

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

brew cask install sql-operations-studio
brew cask install mysqlworkbench
brew cask install dbeaver-community

brew cask install intellij-idea-ce
brew cask install eclipse-ide

brew install awscli
brew install azure-cli
brew cask install google-cloud-sdk

brew cask install postman
brew cask install macs-fan-control
brew cask install cinch
brew cask install microsoft-office
brew cask install adobe-acrobat-reader
brew cleanup
brew cask cleanup

#Setup Custom Bash Profile for macOS High Sierra
echo "" >> ~/.bash_profile
echo "#Custom Bash Profile for macOS High Sierra" >> ~/.bash_profile
echo 'export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "' >> ~/.bash_profile
echo 'export CLICOLOR=1' >> ~/.bash_profile
echo 'export LSCOLORS=ExFxBxDxCxegedabagacad' >> ~/.bash_profile
echo "alias la='ls -al'" >> ~/.bash_profile
echo "alias powershell='pwsh" >> ~/.bash_profile
echo "alias upgrade='brew update && brew upgrade -y && brew cask upgrade && brew cleanup && brew cask cleanup'" >> ~/.bash_profile

#Setup Java Environment Settings
echo 'if which jenv > /dev/null; then eval "$(jenv init -)"; fi' >> ~/.bash_profile
javaParentPath=/Library/Java/JavaVirtualMachines/
cd $javaParentPath

#Find specific Java Home Directories
#java6Dir=`ls -d *jdk1.6.*/`
#java7Dir=`ls -d *jdk1.7.*/`
java8Dir=`ls -d *jdk1.8.*/`
#java9Dir=`ls -d *jdk-9.*/`
java10Dir=`ls -d *jdk-10.*/`

cd ~
java8Path="${javaParentPath}${java8Dir}Contents/Home/"
java10Path="${javaParentPath}${java10Dir}Contents/Home/"

#Add Java Homes to Java Environments
jenv init
#jenv add $java8Path
#jenv add $java10Path

#Add to Environment Variables to Bash Profile
echo "export JAVA_HOME=${java8Path}" >> ~/.bash_profile
echo "export JDK_HOME=${java8Path}" >> ~/.bash_profile
echo "export JAVA18_HOME=${java8Path}" >> ~/.bash_profile
echo "export JAVA10_HOME=${java10Path}" >> ~/.bash_profile
echo 'export ANT_HOME=/usr/local/opt/ant/libexec' >> ~/.bash_profile
echo 'export GRADLE_HOME=/usr/local/opt/gradle/libexec' >> ~/.bash_profile
echo 'export MAVEN_HOME=/usr/local/opt/maven/libexec' >> ~/.bash_profile
echo "" >> ~/.bash_profile

#Configure Dock Input String Setup
str1="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/"
str2="</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

#Remove all current Dock Applications
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

#Add specified Applications to Dock
app=Launchpad.app && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="Microsoft Outlook.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="Microsoft Excel.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="Google Chrome.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="Firefox Developer Edition.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app=iTerm.app && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="SQL Operations Studio.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="Visual Studio Code.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="IntelliJ IDEA CE.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app=Eclipse.app && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="System Preferences.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"
app="App Store.app" && defaults write com.apple.dock persistent-apps -array-add "${str1}${app}${str2}"

#Refresh Dock
killall Dock
