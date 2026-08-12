#!/usr/bin/env bash

while getopts ":ds" opt; do
  case ${opt} in
    d) dry=true; echo "Dry run." ;;
    s) no_sync=true; echo "Not touching remote." ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

generation=$(nixos-rebuild list-generations --json |   jq -r '.[] | select(.current == true) | .generation')
message="Generation $generation"

read -p "Commit message: " user_message

if [ -n "$user_message" ]; then
    message="$message: $user_message"
fi

if [ -n "$dry" ]; then
    echo "Commit message is \"$message\", ending dry run."
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