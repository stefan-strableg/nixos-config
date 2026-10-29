#!/usr/bin/env bash
set -euo pipefail

# Intended to be run once after pulling the repo.

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR"

read -r -p "Enter hostname for this device: " NEW_HOSTNAME

if [[ ! "$NEW_HOSTNAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid hostname."
    exit 1
fi

# Set hostname.
sudo hostname "$NEW_HOSTNAME"

HOST_DIR="./hosts/$NEW_HOSTNAME"
mkdir -p "$HOST_DIR"

# Initialize host configuration if it doesn't exist.
CONFIG_DIR="/etc/nixos"

if [[ ! -f "$HOST_DIR/hardware-configuration.nix" ]]; then
  if [[ ! -f "$CONFIG_DIR/hardware-configuration.nix" ]]; then
      echo "No hardware-configuration.nix found in $CONFIG_DIR."
      echo "Skipping hardware configuration copy."
  else
      sudo cp "$CONFIG_DIR/hardware-configuration.nix" \
	  "$HOST_DIR/hardware-configuration.nix"
  fi
else
  echo "$HOST_DIR/hawrdware-configuration.nix already exists, keeping it."
fi
if [[ ! -f "$HOST_DIR/configuration.nix" ]]; then
  if [[ -f "$CONFIG_DIR/configuration.nix" ]]; then
      sudo cp "$CONFIG_DIR/configuration.nix" \
	  "$HOST_DIR/configuration.nix"
  else
      touch "$HOST_DIR/configuration.nix"
      echo "No configuration.nix found. Create the host configuration manually."
  fi
else
  echo "$HOST_DIR/configuration.nix already exists, keeping it."
fi
# Ensure the host exists in the flake.
if ! grep -Eq "^[[:space:]]*$NEW_HOSTNAME[[:space:]]*=" flake.nix; then
    echo "Host '$NEW_HOSTNAME' is missing from flake.nix."
    echo "Add a nixosConfigurations entry before rebuilding."
    exit 1
fi

# Build and activate the configuration.
sudo nixos-rebuild switch --flake "$REPO_DIR#$NEW_HOSTNAME"

# Set up Tailscale.
read -r -p "Log into Tailscale now? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo tailscale up --accept-routes
fi

echo "Setup complete."
