#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew tap caskroom/cask
brew tap homebrew/cask-drivers


brew install bash-completion coreutils git node@8 openshift-cli	openssl


brew cask install jetbrains-toolbox spectacle flycut iterm2 visual-studio-code docker java8 postman sourcetree flux google-featured-photos logitech-options p4v rocket-chat


#these come after we have installed java ;)
brew install gradle maven

git clone https://github.com/braver/fonts.git programming-fonts-for-atom
curl https://fonts.google.com/download?family=IBM%20Plex%20Mono|Overpass%20Mono

mkdir tools
cd tools
git clone https://github.com/morwed/scripts.git

ln -s ~/tools/scripts/.gitconfig ~/.gitconfig
ln -s ~/tools/scripts/.bashrc ~/.bashrc
ln -s ~/.bashrc ~/.bash_profile
