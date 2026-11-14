#!/usr/bin/env bash

if [[ -f flake.nix ]]; then
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "[WSL] Opening VS Code inside nix develop"
        nix develop -c code .
    else
        echo "[Nix] Opening VS Code with vscode dev shell"
        nix develop -c nix develop .#vscode -c code .
    fi
elif [[ -d .devcontainer ]]; then
    echo "[Devcontainer] Opening VS Code with devcontainer"
    code .
else
    echo "[Default] Opening VS Code"
    code .
fi