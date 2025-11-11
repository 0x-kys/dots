#!/bin/bash
# monolith - dotfiles installer using GNU Stow

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES="hyprland waybar mako nvim fish kitty"

echo "🖤 monolith - minimal monochrome rice installer"
echo "================================================"
echo ""

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow is not installed!"
    echo "Install it with: sudo dnf install stow"
    exit 1
fi

cd "$DOTFILES_DIR"

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d ".git" ]; then
    echo "❌ Error: This doesn't look like the dotfiles directory"
    exit 1
fi

echo "📦 Installing packages: $PACKAGES"
echo ""

for package in $PACKAGES; do
    if [ -d "$package" ]; then
        echo "  → Installing $package..."
        stow -v "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
    else
        echo "  ⚠️  Package $package not found, skipping..."
    fi
done

echo ""
echo "✅ Installation complete!"
echo ""
echo "Your configs are now symlinked from:"
echo "  ~/.config/* → ~/dev/rndm/dots/*/.config/*"
echo ""
echo "To uninstall: cd ~/dev/rndm/dots && stow -D $PACKAGES"
echo ""
