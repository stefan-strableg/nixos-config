#!/usr/bin/env bash
set -euo pipefail

# Lint all nix files in repo
for file in $(find . -name '*.nix'); do
  echo "Linting $file"
  nixfmt "$file"
done