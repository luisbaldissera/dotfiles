#!/bin/bash

NVIM_CONFIG_DIR=${NVIM_CONFIG_DIR:-$HOME/.config/nvim}

# Configure nvim
if ! hash nvim 2>/dev/null
then
    echo "Error (nvim): You need to install nvim first."
else
    echo -n "Configuring nvim ... "
    mkdir -p $NVIM_CONFIG_DIR
    cp -r .config/nvim/. $NVIM_CONFIG_DIR
    echo "OK"
fi
