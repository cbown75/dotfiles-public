#!/usr/bin/env bash
#
# migrate-claude-config.sh
# Migrates Claude Code configuration to new structure
#
# This script:
# 1. Backs up existing ~/.claude (if it exists)
# 2. Removes old ~/.dotfiles-public/.claude directory
# 3. Clones the claude repo directly to ~/.claude
# 4. Symlinks machine-specific .claude.json from dotfiles
#

set -e

CLAUDE_REPO="git@github.com:cbown75/claude.git"
BACKUP_DIR="$HOME/.claude.backup.$(date +%Y%m%d-%H%M%S)"

echo "🔄 Migrating Claude Code configuration..."

# Backup existing ~/.claude if it exists and is not already a backup
if [ -e "$HOME/.claude" ] && [ ! -L "$HOME/.claude" ]; then
    echo "📦 Backing up existing ~/.claude to $BACKUP_DIR"
    mv "$HOME/.claude" "$BACKUP_DIR"
elif [ -L "$HOME/.claude" ]; then
    echo "🗑️  Removing existing ~/.claude symlink"
    rm "$HOME/.claude"
fi

# Remove old .claude from dotfiles-public if it exists
if [ -d "$HOME/.dotfiles-public/.claude" ]; then
    echo "🗑️  Removing ~/.dotfiles-public/.claude"
    rm -rf "$HOME/.dotfiles-public/.claude"
fi

# Clone the repo directly to ~/.claude
echo "📥 Cloning claude repo to ~/.claude"
git clone "$CLAUDE_REPO" "$HOME/.claude"

# Symlink .claude.json from dotfiles (if it exists)
if [ -f "$HOME/.dotfiles/.claude.json" ]; then
    echo "🔗 Symlinking ~/.claude.json from dotfiles"
    ln -sf "$HOME/.dotfiles/.claude.json" "$HOME/.claude.json"
else
    echo "⚠️  Warning: ~/.dotfiles/.claude.json not found"
    echo "   You'll need to create .claude.json with your MCP server configs"
fi

echo "✅ Migration complete!"
echo ""
echo "Next steps:"
echo "  1. Verify ~/.claude is working: ls -la ~/.claude"
echo "  2. Verify .claude.json exists: ls -la ~/.claude.json"
echo "  3. Launch Claude Code and test the configuration"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "Your old configuration was backed up to: $BACKUP_DIR"
    echo "You can safely delete it after verifying everything works."
fi
