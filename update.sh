#!/usr/bin/env bash

# This is a script to help automate the process of committing after editing the nixos config

# Authored by Stefan Strableg

while getopts ":dsm:nu" opt; do
  case ${opt} in
    d) dry=true; echo "Dry run." ;;
    s) no_sync=true; echo "Not touching remote." ;;
    m) user_message="$OPTARG" ;;
    u) update=true; ;;
    n) no_message=true ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

if ! sudo nixos-rebuild switch --flake .#${HOSTNAME}; then
    echo "Build failed, aborting."
    exit 1
fi

generation=$(nixos-rebuild list-generations --json | jq -r '.[] | select(.current == true) | .generation')

if [ -n "$update" ]; then
    if ! nix flake update --flake . || ! git add .; then
        echo "Update failed, aborting."
        exit 1
    fi
    if [ -zn "$dry" ]; then
        echo "Commit message would be \"Generation $generation: Update inputs\""
        exit
    else
        if ! git commit -m "Generation $generation: Update inputs"; then
            echo "Commit failed, aborting."
            exit 1
        fi
    fi
    if [ -z "$no_sync" ]; then
        git push
    fi
fi

if [ -z "$user_message" ] &&  [ -z "$no_message" ]; then
    read -p "Commit message: " user_message
fi

message="Generation $generation"

if [ -n "$user_message" ]; then
    message="$message: $user_message"
fi

if [ -n "$dry" ]; then
    echo "Commit message would be \"$message\"."
    exit
fi

git add .

if ! git commit -m "$message"; then
    echo "Add/Commit failed, aborting."
    exit 1
fi

if [ -z "$no_sync" ]; then
    git push
fi