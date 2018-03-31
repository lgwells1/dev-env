#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new MacOS machine
#
# Based on gist: https://gist.github.com/codeinthehole/26b37efa67041e1307db
#

# Confirm sudo permissions
function ask_for_sudo() {
    info "Prompting for sudo password..."
    if sudo --validate; then
        # Keep-alive
        while true; do sudo --non-interactive true; \
            sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        success "Sudo credentials updated."
    else
        error "Obtaining sudo credentials failed."
        exit 1
}

echo "Starting bootstrapping..."

echo "Confirming sudo permissions..."
ask_for_sudo

echo "Confirming Xcode installation..."
xcode-select --install

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    autoconf
    automake
    boot2docker
    ffmpeg
    gettext
    gifsicle
    git
    graphviz
    hub
    imagemagick
    jq
    libjpeg
    libmemcached 
    lynx
    markdown
    memcached
    mercurial
    npm
    pkg-config
    postgresql
    python
    python3
    pypy
    rabbitmq
    rename
    ssh-copy-id
    terminal-notifier
    the_silver_searcher
    tmux
    tree
    vim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Configuring MacOS..."

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Bootstrapping complete"

