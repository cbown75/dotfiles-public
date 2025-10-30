# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **dotfiles repository** for macOS system configuration using GNU Stow for symlink management. It contains shell configurations (zsh/bash), Neovim setup optimized for DevOps workflows, terminal emulator configs (Ghostty, Kitty, Tmux), utility scripts, and various dotfiles.

## Repository Architecture

### Core Configuration Pattern

This repository uses **symlinks via GNU Stow** to deploy dotfiles from this repo to the home directory. Files in the root are symlinked directly (e.g., `.zshrc` → `~/.zshrc`), while the `.config/` directory gets symlinked as `~/.config/` subdirectories.

The `.stowrc` file configures Stow to ignore `.DS_Store` files during deployment.

### Shell Configuration System

The shell setup has a **layered sourcing architecture**:

1. **Primary shell configs**: `.zshrc` (97 lines) and `.bashrc` in the root
2. **Auto-installation**: `.rc/.zsh-autoinstall` - Automatically installs Oh My Zsh, Powerlevel10k, plugins, and tools on first run
3. **Tool initialization**: `.rc/.zsh-tools` - Conditionally initializes development tools (pyenv, fzf, zoxide, direnv)
4. **Common aliases/functions**: `.rc/.commonrc` (sourced by both shells)
5. **Tool-specific configs**:
   - `.rc/.fabricrc` - Fabric AI CLI patterns and functions
   - `.rc/.installrc` - Neovim development tools auto-installer
6. **Private configs**: `~/.private/{.cloudflarerc,.spaceliftrc,.stratusrc,.privaterc,.sshrc}` (not in this repo, sourced conditionally)

The `.rc/.zsh-autoinstall` script performs **automatic installation** of:
- Oh My Zsh framework
- Powerlevel10k theme
- Plugins: fzf-tab, zsh-completions, you-should-use, zsh-syntax-highlighting, zsh-autosuggestions
- mcp-grafana Go binary

### Neovim Configuration Architecture

Location: `.config/nvim/`

**Structure**:
- `init.lua` - Entry point that loads modules
- `config/` - Core configuration (options, lazy plugin manager, autocmds)
- `config/keymaps/` - **Modular keymap system** organized by domain:
  - `init.lua` - Loads all keymap modules
  - `core.lua` - Basic editor operations
  - `devops.lua` - General DevOps operations
  - `kubernetes.lua` - K8s-specific commands
  - `terraform.lua` - Terraform operations
  - `aws.lua`, `docker.lua`, `python.lua` - Domain-specific tools
  - `git.lua`, `navigation.lua`, `lsp.lua`, `tmux.lua`, `ai.lua`, `oil.lua`
- `plugins/` - Individual plugin configurations (Lazy.nvim managed, auto-loaded)
- `lib/` - Shared utilities (e.g., `icons.lua`)

**Philosophy**: This is a **DevOps-focused Neovim config** with deep integrations for Kubernetes (K9s), Terraform, AWS CLI, Docker, and Python. The keymap structure uses `<leader>o` as the primary DevOps prefix with subgroups (e.g., `<leader>ok` for Kubernetes, `<leader>ot` for Terraform).

## Important Files and Their Roles

### Shell Entry Points
- `.zshrc` - Primary zsh configuration with auto-installation logic for Oh My Zsh ecosystem
- `.bashrc` - Minimal bash config that sources fzf and Cargo env
- `.rc/.commonrc` - Shared aliases (vim→nvim, kubectl shortcuts, git helpers, directory navigation shortcuts)

### Tool Integrations
- `.rc/.zsh-autoinstall` - Automatic installer for Oh My Zsh ecosystem (sourced in `.zshrc:28`)
- `.rc/.zsh-tools` - Conditional initialization for development tools: pyenv, fzf, zoxide, direnv (sourced in `.zshrc:90`)
- `.rc/.fabricrc` - Creates dynamic shell functions for all Fabric AI patterns (loops through `~/.config/fabric/patterns/*`), plus `yt()` function for YouTube transcript extraction
- `.rc/.installrc` - Interactive installer for Neovim LSP/formatter dependencies (black, isort, prettier, rustfmt, taplo, goimports, tree-sitter, utftex, mmdc, neovim npm package, jsregexp)
- `.kubectl_aliases` - Extensive kubectl alias definitions (sourced in `.zshrc`)
- `.p10k.zsh` - Powerlevel10k theme configuration

### Utility Scripts (`bin/`)
- `extractwisdom` - YouTube video transcript extraction via Fabric AI to Obsidian
- `gitsetup` - Configures Git settings (rerere, branch sorting, SSH signing)
- `macsetup` - Sets macOS keyboard repeat rates
- `git-delete-local-merged`, `git-undo`, `git-wtf`, `git-rank-contributers` - Git utilities

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

# Update all Homebrew packages (alias in .rc/.commonrc:21)
brews

# Morning routine: update brews and pull all git repos (alias in .rc/.commonrc:23)
goodmorning
```

### Neovim

```bash
# Open Neovim
nvim  # or use aliases: v, vim

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
- `.zshrc:113-127` - Adds pyenv, Perl local::lib paths
- `.rc/.installrc:136-151` - `ensure_tool_paths()` adds tool-specific paths

### Neovim LSP Dependencies
The `.rc/.installrc` script manages formatters and LSP tools. These are referenced by Neovim LSP configs in `.config/nvim/plugins/`. If adding new language support, update both the Neovim plugin config AND the `.installrc` tool list.

### Terminal Emulator Configs
Configuration files exist for multiple terminal emulators under `.config/`:
- Ghostty (`.config/ghostty/`)
- Kitty (`.config/kitty/`)
- Tmux (`.config/tmux/`)
- Zellij (`.config/zellij/`)
- Aerospace window manager (`.config/aerospace/`)
- Starship prompt (`.config/starship.toml`)

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

### Keymap Loading
The Neovim keymap loader (`.config/nvim/lua/config/keymaps/init.lua`) loads keymap modules in a specific order. Currently loaded: core, devops, kubernetes, git, ai, lsp, navigation, tmux, oil. Additional keymap files exist (aws, docker, python, terraform) but are not loaded by default.

## Working with This Repository

When modifying configurations:
1. **Shell aliases/functions** - Add to `.rc/.commonrc` for shared items, or tool-specific files
2. **Neovim keymaps** - Add to appropriate file in `.config/nvim/lua/config/keymaps/`, then update `.config/nvim/lua/config/keymaps/init.lua` to load it
3. **Neovim plugins** - Create new file in `.config/nvim/lua/plugins/` (auto-loaded by Lazy.nvim)
4. **Utility scripts** - Add to `bin/` directory (already in PATH via `.zshrc:6`)
5. **Tool configs** - Place in `.config/{tool-name}/` and they'll be symlinked by Stow

Always test changes by sourcing config files or restarting the shell before committing.

## Custom Claude Code Agents

**Location**: `~/.claude/agents/`

The repository includes custom agents for knowledge management:

**obsidian-knowledge-capture.md** - Creates comprehensive technical content in Obsidian vault including reference documentation, guides, how-tos, and research notes. Handles both code/config analysis and knowledge capture from conversations following PARA methodology.

**Usage**:
```
# Document code/configs
User: "Document my Neovim configuration"
→ Analyzes .config/nvim/ structure
→ Creates comprehensive guide in Resources/Dotfiles/

# Capture knowledge
User: "Create a guide for deploying to AKS"
→ Structures knowledge from conversation
→ Creates how-to in Resources/DevOps/
```

**Features**:
- Two modes: Code Analysis (reads/analyzes first) and Knowledge Capture (from conversation)
- Follows PARA methodology (Projects/Areas/Resources/Archives)
- Uses existing hierarchical tag taxonomy
- Creates cross-linked, searchable documentation
- Includes: overview, architecture, features, configuration, usage, troubleshooting
- Writes directly to filesystem (avoids MCP patch issues)
- Consolidates functionality of previous documentation and poster agents

**obsidian-work-logger.md** - Logs daily work activities to temporal notes in Notes/Work Notes/YYYY/MM-MMMM/

**obsidian-rca-logger.md** - Creates root cause analysis documents for incidents in Notes/Work Notes/RCA/

## Summary of Recent Changes

During analysis and cleanup, the following improvements were made:
1. **KUBECONFIG typo** - Fixed typo in `.zshrc` (was `KUEBCONFIG`, now `KUBECONFIG`)
2. **Missing LSP integration** - Added `nvim-lsp-file-operations.lua` plugin for neo-tree LSP file operations
3. **Missing oil keymaps** - Added `require("config.keymaps.oil")` to `.config/nvim/lua/config/keymaps/init.lua`
4. **Modular .zshrc** - Reduced from 127 to 97 lines by extracting:
   - Installation checks → `.rc/.zsh-autoinstall`
   - Tool initialization → `.rc/.zsh-tools`
   - Improved PATH management with `add_to_path()` helper function
   - Cleaned up config sourcing with single-line conditionals
5. **PATH deduplication** - Upgraded `add_to_path()` to prevent duplicates
6. **Consolidated Obsidian agents** - Merged obsidian-documentation and obsidian-poster into single obsidian-knowledge-capture agent (reduced from 952 to 712 lines, eliminated 70% duplication)
