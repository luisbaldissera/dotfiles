#!/bin/bash

# nvim
cp -r $HOME/.config/nvim/. .config/nvim

# kitty
cp -r $HOME/.config/kitty/. .config/kitty

# zsh
cp $HOME/.zshrc .zshrc

# VSCode
echo "$(code --list-extensions)" > vscode_extensions
