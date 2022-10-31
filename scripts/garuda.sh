#! /bin/bash

scriptDir=$( dirname "${BASH_SOURCE[0]}" )
currentDir=$( pwd )

cd $scriptDir/..


# Update
sudo apt-get update
sudo apt-get upgrade


# Install and prep ZSH for stow
sudo apt-get install zsh curl
sudo chsh --shell /usr/bin/zsh

if [ ! -d /home/cole/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  rm $HOME/.zshrc
fi


# Install flatpak and flathub
sudo apt-get install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.brave.Browser
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.spotify.Client


# Install stow and install dotfiles
sudo apt-get install -y stow

cd dotfiles
s
stow --target=/home/cole zsh

cd ..

cd $currentDir