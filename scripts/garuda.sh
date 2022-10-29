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


# Remove snapd
sudo rm -rf /var/cache/snapd
snap remove --purge firefox
sudo apt-get autoremove --purge -y snapd gnome-software-plugin-snap
sudo apt-mark hold snapd
rm -rf ~/snap


# Install flatpak and flathub
sudo apt-get install -y flatpak
sudo apt-get install gnome-software gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.brave.Browser
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.spotify.Client


# Install Pop!_OS shell
sudo apt-get install -y gnome-shell-extensions gnome-shell-extensions-manager node-typescript make

git clone https://github.com/pop-os/shell.git pop-os-shell
cd pop-os-shell
git checkout master_jammy
make local-install


# Install stow and install dotfiles
sudo apt-get stow

cd dotfiles

stow --target=/home/cole zsh

cd ..



cd $currentDir

sudo reboot now