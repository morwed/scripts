#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew tap caskroom/cask
brew tap homebrew/cask-drivers

brew install git bash-completion

brew cask install brave flux google-featured-photos jetbrains-toolbox meld slack spectacle flycut iterm2 kdiff3 visual-studio-code docker google-chrome java8 logitech-options postman sourcetree vlc

mkdir tools
cd tools
git clone https://github.com/morwed/scripts.git

ln -s ~/tools/scripts/.gitconfig ~/.gitconfig
ln -s ~/tools/scripts/.bashrc ~/.bashrc
ln -s ~/.bashrc ~/.bash_profile
