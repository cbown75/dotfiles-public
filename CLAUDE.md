# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **dotfiles repository** for macOS system configuration using GNU Stow for symlink management. It contains shell configurations (zsh/bash), Neovim setup optimized for DevOps workflows, terminal emulator configs (Alacritty, Kitty, Ghostty, Tmux), utility scripts, and various dotfiles.

## Repository Architecture

### Core Configuration Pattern

This repository uses **symlinks via GNU Stow** to deploy dotfiles from this repo to the home directory. Files in the root are symlinked directly (e.g., `.zshrc` → `~/.zshrc`), while the `.config/` directory gets symlinked as `~/.config/` subdirectories.

The `.stowrc` file configures Stow to ignore `.DS_Store` files during deployment.

### Shell Configuration System

The shell setup has a **layered sourcing architecture**:

1. **Primary shell configs**: `.zshrc` and `.bashrc` in the root
2. **Common aliases/functions**: `~/.rc/.commonrc` (sourced by both shells)
3. **Tool-specific configs**:
   - `~/.rc/.fabricrc` - Fabric AI CLI patterns and functions
   - `~/.rc/.installrc` - Neovim development tools auto-installer
4. **Private configs**: `~/.private/{.cloudflarerc,.spaceliftrc,.stratusrc,.sshrc}` (not in this repo, sourced conditionally)

The `.zshrc` performs **automatic installation** of Oh My Zsh plugins on first run:
- Powerlevel10k theme
- fzf-tab, zsh-completions, you-should-use
- zsh-syntax-highlighting, zsh-autosuggestions

### Neovim Configuration Architecture

Location: `.config/nvim/`

**Structure**:
- `init.lua` - Entry point that loads modules
- `config/` - Core configuration (options, lazy plugin manager, autocmds, keymaps)
- `config/keymaps/` - **Modular keymap system** organized by domain:
  - `core.lua` - Basic editor operations
  - `devops.lua` - General DevOps operations
  - `kubernetes.lua` - K8s-specific commands
  - `terraform.lua` - Terraform operations
  - `aws.lua`, `docker.lua`, `python.lua` - Domain-specific tools
  - `git.lua`, `navigation.lua`, `lsp.lua`, `tmux.lua`, `ai.lua`
- `plugins/` - Individual plugin configurations (Lazy.nvim managed)
- `lib/` - Shared utilities (e.g., `icons.lua`)
- `setup/` - Setup utilities

**Philosophy**: This is a **DevOps-focused Neovim config** with deep integrations for Kubernetes (K9s), Terraform, AWS CLI, Docker, and Python. The keymap structure uses `<leader>o` as the primary DevOps prefix with subgroups (e.g., `<leader>ok` for Kubernetes, `<leader>ot` for Terraform).

## Important Files and Their Roles

### Shell Entry Points
- `.zshrc` - Primary zsh configuration with auto-installation logic for Oh My Zsh ecosystem
- `.bashrc` - Minimal bash config that sources fzf and Cargo env
- `.rc/.commonrc` - Shared aliases (vim→nvim, kubectl shortcuts, git helpers, directory shortcuts)

### Tool Integrations
- `.rc/.fabricrc` - Creates dynamic shell functions for all Fabric AI patterns, plus `yt()` function for YouTube transcript extraction
- `.rc/.installrc` - Interactive installer for Neovim LSP/formatter dependencies (black, isort, prettier, rustfmt, etc.)
- `.kubectl_aliases` - Extensive kubectl alias definitions (sourced in `.zshrc`)
- `.p10k.zsh` - Powerlevel10k theme configuration (lean prompt style)

### Utility Scripts (`bin/`)
- `extractwisdom` - YouTube video transcript extraction via Fabric AI to Obsidian
- `gitsetup` - Configures Git settings (rerere, branch sorting, SSH signing)
- `macsetup` - Sets macOS keyboard repeat rates
- `git-*` scripts - Git utilities (delete-local-merged, undo, wtf, rank-contributers)

### Bootstrap
- `install.sh` - Initial setup script (Xcode CLI tools, Homebrew, Git)

## Common Development Commands

### Managing Dotfiles

```bash
# Deploy dotfiles using GNU Stow (from repo root)
stow .

# Remove deployed symlinks
stow -D .

# Test what would be stowed without making changes
stow -n .
```

### Shell Configuration

```bash
# Reload shell configuration
source ~/.zshrc

# Check/install Neovim development tools interactively
check_and_install_nvim_tools  # defined in .rc/.installrc

# Update all Homebrew packages
brews  # alias defined in .commonrc

# Morning routine: update brews and pull all git repos
goodmorning  # alias defined in .commonrc
```

### Neovim

```bash
# Open Neovim
nvim  # or use alias: v

# Check health of Neovim plugins and dependencies
nvim -c ':checkhealth'

# Update all plugins (uses Lazy.nvim)
# Inside nvim: :Lazy update
```

### Git Configuration

```bash
# Apply recommended git settings
gitsetup
```

## Key Integration Points

### Oh My Zsh Plugin System
The `.zshrc` checks for missing Oh My Zsh plugins and clones them automatically on shell startup. When adding new plugins, update the `plugins=()` array in `.zshrc:74`.

### Fabric AI Integration
The `.rc/.fabricrc` dynamically creates shell functions for every pattern in `~/.config/fabric/patterns/`. Each function accepts an optional title argument and outputs to `$obsidian_base` with date-stamped filenames.

### Path Management
Multiple tools modify `$PATH` across shell configs:
- `.zshrc:6` - Adds Homebrew, Cargo, Java, local bins
- `.zshrc:44` - Adds Go bin for mcp-grafana
- `.zshrc:119-123` - Adds Perl local::lib paths
- `.rc/.installrc:136-151` - `ensure_tool_paths()` adds tool-specific paths

### Neovim LSP Dependencies
The `.rc/.installrc` script manages formatters and LSP tools. These are referenced by Neovim LSP configs in `.config/nvim/plugins/`. If adding new language support, update both the Neovim plugin config AND the `.installrc` tool list.

### Terminal Emulator Configs
Configuration files exist for multiple terminal emulators (Alacritty, Kitty, Ghostty) under `.config/`. The Alacritty config includes a large theme collection under `.config/alacritty/themes/`.

## Filesystem Layout Assumptions

- Dotfiles are managed in `~/.dotfiles-public/` (this repo)
- Private configs live in `~/.private/` (git-ignored, conditionally sourced)
- Oh My Zsh installs to `~/.oh-my-zsh/`
- Neovim data directory follows XDG: `~/.local/share/nvim/`
- Obsidian vault path: `~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian/`

## Special Considerations

### macOS-Specific
- Uses Homebrew with Apple Silicon paths (`/opt/homebrew`)
- macOS keyboard repeat settings via `bin/macsetup`
- iCloud Obsidian integration paths

### Git Submodules
The repository includes fzf as a Git submodule (`.gitmodules`). After cloning:
```bash
git submodule update --init --recursive
```

### Untracked Config Directories
Per git status, `.config/alacritty/` and `.oh-my-zsh/` are currently untracked. The `.config/alacritty/` directory exists in the repo but may have local modifications.

## Working with This Repository

When modifying configurations:
1. **Shell aliases/functions** - Add to `.rc/.commonrc` for shared items, or tool-specific files
2. **Neovim keymaps** - Add to appropriate file in `.config/nvim/lua/config/keymaps/`
3. **Neovim plugins** - Create new file in `.config/nvim/lua/plugins/` (auto-loaded by Lazy.nvim)
4. **Utility scripts** - Add to `bin/` directory (already in PATH via `.zshrc`)
5. **Tool configs** - Place in `.config/{tool-name}/` and they'll be symlinked by Stow

Always test changes by sourcing config files or restarting the shell before committing.
