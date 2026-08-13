#!/usr/bin/env bash

# This script is intended to be run once after pulling the repo

# Authored by Stefan Strableg

set -euo pipefail

# Set hostname, so correct flake will be picked
read -p "Enter hostname for this device:" NEW_HOSTNAME
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

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