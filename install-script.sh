#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap AdoptOpenJDK/openjdk
brew tap homebrew/cask
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions


brew install bash-completion coreutils docker-completion docker-compose-completion git gradle-completion jhead jq nvm openssl

mkdir ~/.nvm

brew cask install adoptopenjdk8 docker flycut google-featured-photos iterm2 jetbrains-toolbox logitech-options meld postman rocket-chat sourcetree spectacle visual-studio-code

#these come after we have installed java ;)
brew install gradle groovysdk



mkdir ~/tools
cd ~/tools
git clone https://github.com/morwed/scripts.git
curl "https://fonts.google.com/download?family=IBM%20Plex%20Mono|Overpass%20Mono" --output ibm-fonts.zip


ln -sv ~/tools/scripts/.gitconfig ~/.gitconfig
ln -sv ~/tools/scripts/.bashrc ~/.bashrc
ln -sv ~/.bashrc ~/.bash_profile
mkdir ~/.ssh
ln -sv ~/tools/scripts/ssh_config ~/.ssh/config
sudo ln -svf ~/tools/scripts/Company.ppx ~/Library/Application\ Support/Proxifier/Profiles/
ln -sv ~/tools/scripts/git-stuff/hooks/prepare-commit-msg ~/git/hooks/


#enable "allow from anywhere" option in System Preferences>Security&Privacy>"Allow apps downloaded from:"
sudo spctl --master-disable
#show hidden folders/files by default in Finder
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
