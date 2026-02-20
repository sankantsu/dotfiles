#!/bin/sh

set -e

# System packages
# TODO: Support other package managers
apt-get update
apt-get install -y git wget curl unzip

# Neovim
mkdir -p ~/opt/
cd ~/opt/
wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
tar zxvf nvim-linux-x86_64.tar.gz
echo 'export PATH=${PATH}:$HOME/opt/nvim-linux-x86_64/bin' >>~/.bashrc
echo 'alias vi=nvim' >>~/.bash_aliases

# Dotfiles
cd ~/opt
mkdir -p ~/.config
git clone https://github.com/sankantsu/dotfiles.git
ln -s ~/opt/dotfiles/nvim ~/.config/nvim

# Plugin dependencies

## deno
curl -fsSL https://deno.land/install.sh | sh -s -- -y

## fd, rg
apt-get install -y fd-find ripgrep

# Message
echo "Install finished!"
echo "Run following commands to update the environment variables"
echo 'source ~/.bashrc'
