#!/usr/bin/env bash

# This script is intended to be run once after pulling the repo

# Authored by Stefan Strableg

set -euo pipefail

add_host_to_flake() {
  local host="$1"

  sed -i "/^      [a-zA-Z0-9_-]* = nixpkgs.lib.nixosSystem {/i\\
      $host = nixpkgs.lib.nixosSystem {\\
        system = \"x86_64-linux\";\\
        modules = [];\\
      };\\
" flake.nix
}

# Set hostname, so correct flake will be picked
read -p "Enter hostname for this device:" NEW_HOSTNAME
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

# If this device was not set up until now
if [ ! -d "./hosts/$NEW_HOSTNAME" ]; then
    read -p "$NEW_HOSTNAME does not exist in config. Do you want to initialize it with the contents of /etc/nix? [y/N]" yn
    if [ yn -eq "y" ]; then
        mkdir ./hosts/$NEW_HOSTNAME -p
        sudo cp /etc/nix/hardware-configuration.nix ./hosts/$NEW_HOSTNAME/hardware-configuration.nix
        sudo cp /etc/nix/configuration.nix ./hosts/$NEW_HOSTNAME/configuration.nix
        echo "Copied config."
    else
        echo "Didn't copy config."
    fi
    add_host_to_flake $NEW_HOSTNAME
fi

# Initial build
sudo nixos-rebuild switch --flake "~/nixos-config#$NEW_HOSTNAME"

# Setup Accounts
echo "[1/2] Set up GNOME Online Accounts and close the window:"
sleep 1
gnome-control-center online-accounts >/dev/null 2>&1

echo "[2/2] Log into Tailscale:"
sudo tailscale up --accept-routes

echo "Done!"
read -p "Press any letter to log out of the GNOME Environment and log back in..."
gnome-session-quit --logout --no-prompt