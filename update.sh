#!/usr/bin/env bash

while getopts ":dsm:n" opt; do
  case ${opt} in
    d) dry=true; echo "Dry run." ;;
    s) no_sync=true; echo "Not touching remote." ;;
    m) user_message="$OPTARG" ;;
    n) no_message=true ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

if [ -z "$user_message" ] &&  [ -z "$no_message" ]; then
    read -p "Commit message: " user_message
fi

if ! sudo nixos-rebuild switch --flake .#$HOSTNAME; then
    echo "Build failed, aborting."
    exit
fi

generation=$(nixos-rebuild list-generations --json |   jq -r '.[] | select(.current == true) | .generation')
message="Generation $generation"

if [ -n "$user_message" ]; then
    message="$message: $user_message"
fi

if [ -n "$dry" ]; then
    echo "Commit message would be \"$message\"."
    exit 
fi


if [ -n "$no_sync" ] && ! git pull; then
    echo "Failed pulling. Exit."
    exit
fi

git add .
git commit -m "$message"

if [ -n "$no_sync"]; then
    git push
fi