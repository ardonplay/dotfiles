#!/bin/bash

set -e

echo "Installing dotfiles..."

cd "$(dirname "$0")"

if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Please install it:"
    exit 1
fi

# Deploying all packages
for dir in */; do
    if [ -d "$dir" ]; then
        pkg=$(basename "$dir")
        echo "Installing package: $pkg"
        stow "$pkg"
    fi
done

echo "Dotfiles installed successfully!"
echo "Restart your terminal or run 'source ~/.zshrc' to apply changes."