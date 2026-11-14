#!/usr/bin/env bash

if [[ -f flake.nix ]]; then
    echo -en ">> Checking flake...\r"
    if nix eval .#vscode.drvPath &>/dev/null; then
        if grep -qi microsoft /proc/version 2>/dev/null; then
            echo ">> Flake.nix with vscode target detected. WSL detected. The flake's vscode is ignored. Opening windows VSCode in flake environment."
            nix develop -c code .
        else
            echo ">> Flake.nix with vscode target detected. Opening flake's vscode in flake environment."
            nix develop .#vscode -c code .
        fi
    else
        echo ">> Flake.nix detected. Opening VSCode in flake environment."
        nix develop -c code .
    fi
elif [[ -d .devcontainer ]]; then
    echo ">> Devcontainer detected. Opening VSCode. Please manually open the Devcontainer."
    code .
else
    echo ">> Opening VSCode."
    code .
fi