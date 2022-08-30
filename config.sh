#!/bin/bash

NVIM_CONFIG_DIR=${NVIM_CONFIG_DIR:-$HOME/.config/nvim}
KITTY_CONFIG_DIR=${KITTY_CONFIG_DIR:-$HOME/.config/kitty}

# Configure zsh
if ! hash zsh 2>/dev/null
then
    echo "Error (zsh): You need to install zsh first"
fi

# Configure nvim
if ! hash nvim 2>/dev/null
then
    echo "Error (nvim): You need to install nvim and vim-plug first"
else
    echo -n "Configuring nvim ... "
    mkdir -p $NVIM_CONFIG_DIR
    cp -r .config/nvim/. $NVIM_CONFIG_DIR
    echo "OK"
    echo -n "Installing plugins ... "
    nvim -c 'PlugUpdate' -c 'qa'
    echo "OK"
    echo -n "Intalling vimspector languages ... "
    nvim -c 'VimspectorUpdate' -c 'qa'
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

# Configure VS Code
if !hash code 2>/dev/null
    echo "Error (VS Code): You need to install VSCode first"
else
    for id in "$(cat vscode_extensions)"
    do
        EXTENSION_ID=$id
        EXTENSION_NAME=${EXTENSIONS[$id]}
        echo -n "Installing VSCode extension '${EXTENSION_NAME}' ... "
        code --install-extension "${EXTENSION_ID}" &>/dev/null
        echo "OK"
    done
fi
