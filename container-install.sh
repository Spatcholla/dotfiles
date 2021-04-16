#!/bin/bash

apt update

# Install ZSH
apt install -y zsh

# Install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Copy .zshrc
cp .zshrc ~/.zshrc

# Install Neovim
apt install -y software-properties-common
apt install -y neovim

# Install Python modules for Neovim
apt install -y python3-dev python3-pip

# Update editor to Neovim
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

# Install vim-plug for Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy config directory
cp -r .config ~/

# Copy tmux configuration file
cp .tmux.conf ~/

# Install Python modules
python3 -m pip install -U pip setuptools neovim

echo "---------------------------"
echo "RUN THE FOLLOWING COMMAND:"
echo "chsh -s \$(which zsh)"

