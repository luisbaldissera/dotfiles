#!/bin/bash

NVIM_CONFIG_DIR=${NVIM_CONFIG_DIR:-$HOME/.config/nvim}
KITTY_CONFIG_DIR=${KITTY_CONFIG_DIR:-$HOME/.config/kitty}

# Configure nvim
if ! hash nvim 2>/dev/null
then
    echo "Error (nvim): You need to install nvim and vim-plug first"
else
    echo -n "Configuring nvim ... "
    mkdir -p $NVIM_CONFIG_DIR
    cp -r .config/nvim/. $NVIM_CONFIG_DIR
    nvim -c 'PlugInstall' -c 'qa'
    echo "OK"
fi

# Configure kitty
if ! hash kitty 2>/dev/null
then
    echo "Error (kitty): You need to install kitty first"
else
    echo -n "Configuring kitty ... "
    mkdir -p $KITTY_CONFIG_DIR
    cp -r .config/kitty/. $KITTY_CONFIG_DIR
    echo "OK"
fi
