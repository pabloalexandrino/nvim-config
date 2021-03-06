#!/bin/bash

# Adapted from https://github.com/Optixal/neovim-init.vim

set -e

# Make config directory for Neovim's init.vim
echo '[*] Preparing Neovim config directory ...'
mkdir -p ~/.config/nvim

# Install nvim and its dependencies
echo '[*] Using Homebrew to install Neovim and its dependencies ...'
brew install neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
pip install neovim

# Install vim-plug plugin manager
echo '[*] Downloading vim-plug ...'
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

# Install a nerd font for icons and a beautiful airline bar
echo "[*] Installing patched font ..."
brew cask install font-firacode-nerd-font

# Enter Neovim and install plugins using a temporary init.vim, which avoids 
# warnings about missing colorschemes, functions, etc
echo -e '[*] Running :PlugInstall within nvim ...'
sed '/command! PackStatus/q' init.vim > ~/.config/nvim/init.vim
nvim -c ':PackUpdate' -c ':UpdateRemotePlugins' -c ':qall'
rm ~/.config/nvim/init.vim

# Link init.vim in current working directory to nvim's config location ...
echo '[*] Linking init.vim -> ~/.config/nvim/init.vim'
ln -s $PWD/init.vim ~/.config/nvim/

echo -e "[+] Done"

