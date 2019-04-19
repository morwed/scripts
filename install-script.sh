#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew tap caskroom/cask
brew tap homebrew/cask-drivers


brew install bash-completion coreutils git nvm openshift-cli openssl docker-compose-completion maven-completion gradle-completion jhead docker-completion
mkdir ~/.nvm

brew cask install docker flycut google-featured-photos iterm2 java8 jetbrains-toolbox logitech-options postman rocket-chat sourcetree spectacle visual-studio-code kdiff3 meld


#these come after we have installed java ;)
brew install gradle maven groovysdk


git clone https://github.com/braver/fonts.git programming-fonts-for-atom
curl https://fonts.google.com/download?family=IBM%20Plex%20Mono|Overpass%20Mono


mkdir tools
cd tools
git clone https://github.com/morwed/scripts.git


ln -s ~/tools/scripts/.gitconfig ~/.gitconfig
ln -s ~/tools/scripts/.bashrc ~/.bashrc
ln -s ~/.bashrc ~/.bash_profile
ln -s ~/tools/scripts/ssh_config ~/.ssh/config


#enable "allow from anywhere" option in System Preferences>Security&Privacy>"Allow apps downloaded from:"
sudo spctl --master-disable
#show hidden folders/files by default in Finder
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder