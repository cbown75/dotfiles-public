# Neovim Configuration

A comprehensive and modular Neovim configuration with carefully selected plugins and keymappings to enhance productivity.

## Table of Contents

- [Installation](#installation)
- [Structure](#structure)
- [Plugins](#plugins)
- [Keymaps](#keymaps)
- [Options](#options)
- [Features](#features)
- [K9s Integration](#k9s-integration)
- [Recent Improvements](#recent-improvements)

## Installation

1. Clone this repository to your Neovim configuration directory:
   ```bash
   git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
   ```
2. Start Neovim, and the plugins will be automatically installed using Lazy.nvim:
   ```bash
   nvim
   ```

## Structure

The configuration is organized into multiple files:

- `init.lua`: Main entry point that loads all configuration components
- `config/options.lua`: General Neovim options and settings
- `config/lazy.lua`: Plugin manager setup
- `config/autocmd.lua`: Autocommands configuration
- `config/keymaps.lua`: Centralized key mappings for all operations
- `plugins/*.lua`: Individual plugin definitions and configurations
- `setup/*.lua`: Custom setup files for specific plugins (lualine, fzf)

## Plugins

The configuration uses [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

### Core Plugins

| Plugin                                                                        | Description                       |
| ----------------------------------------------------------------------------- | --------------------------------- |
| [mbbill/undotree](https://github.com/mbbill/undotree)                         | Visualize and browse undo history |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)                       | Fuzzy finder integration          |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)     | Status line                       |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Icons for UI elements             |
| [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)               | Quick file navigation             |
| [folke/flash.nvim](https://github.com/folke/flash.nvim)                       | Enhanced motion and navigation    |

### AI Integration

| Plugin                                                      | Description                       |
| ----------------------------------------------------------- | --------------------------------- |
| [yetone/avante.nvim](https://github.com/yetone/avante.nvim) | AI assistant integration (Claude) |

### UI Enhancements

| Plugin                                                                          | Description                            |
| ------------------------------------------------------------------------------- | -------------------------------------- |
| [utilyre/barbecue.nvim](https://github.com/utilyre/barbecue.nvim)               | VS Code-like winbar context            |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)           | Buffer line with tabpage integration   |
| [binhtran432k/dracula.nvim](https://github.com/binhtran432k/dracula.nvim)       | Dracula colorscheme                    |
| [folke/noice.nvim](https://github.com/folke/noice.nvim)                         | UI for messages, cmdline and popupmenu |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim)                 | Display key bindings                   |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim)                       | Collection of small utility features   |
| [echasnovski/mini.indentscope](https://github.com/echasnovski/mini.indentscope) | Visual indentation guides              |
| [echasnovski/mini.icons](https://github.com/echasnovski/mini.icons)             | Icons for UI                           |

### Editor Features

| Plugin                                                                                                    | Description                        |
| --------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                                   | Completion engine                  |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                                   | Snippet engine                     |
| [folke/flash.nvim](https://github.com/folke/flash.nvim)                                                   | Enhanced navigation and search     |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)                                         | Code formatting                    |
| [tpope/vim-surround](https://github.com/tpope/vim-surround)                                               | Surround text with pairs           |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                             | File explorer                      |
| [AckslD/nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                     | Clipboard manager                  |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                         | Fuzzy finder framework             |
| [nathom/tmux.nvim](https://github.com/nathom/tmux.nvim)                                                   | Tmux integration                   |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                                   | Highlight and search TODO comments |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown previewer                 |

### Development Tools

| Plugin                                                                                | Description                              |
| ------------------------------------------------------------------------------------- | ---------------------------------------- |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)                 | Package manager for LSP/DAP/linters      |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                     | LSP configuration                        |
| [vhyrro/luarocks.nvim](https://github.com/vhyrro/luarocks.nvim)                       | Luarocks package manager                 |
| [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)                   | Diagnostics, formatting, and more        |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Parser generator and syntax highlighting |
| [folke/trouble.nvim](https://github.com/folke/trouble.nvim)                           | A diagnostics panel                      |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                           | Git integration                          |
| [tpope/vim-projectionist](https://github.com/tpope/vim-projectionist)                 | Project configuration                    |
| [nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre)                   | Search and replace across files          |
| [SmiteshP/nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy)                   | Code navigation popup                    |

### Debugging

| Plugin                                                            | Description                   |
| ----------------------------------------------------------------- | ----------------------------- |
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)   | UI for nvim-dap               |

### DevOps Integrations

| Plugin                                                  | Description                    |
| ------------------------------------------------------- | ------------------------------ |
| Custom K9s Integration                                  | Kubernetes management with K9s |
| [nathom/tmux.nvim](https://github.com/nathom/tmux.nvim) | Enhanced Tmux integration      |

## Keymaps

Keymaps are centralized in `config/keymaps.lua` to avoid conflicts and make them easier to discover and maintain.

### Core Operations

| Key                | Mode   | Action            | Description                     |
| ------------------ | ------ | ----------------- | ------------------------------- |
| `<Space>`          | All    | Leader key        | Global leader key               |
| `<Esc>`            | Normal | `:nohlsearch<CR>` | Clear search highlights         |
| `jj`               | Insert | `<Esc>`           | Exit insert mode                |
| `<C-h/j/k/l>`      | Normal |                   | Navigate between tmux/vim panes |
| `,`                | Normal | `:w<CR>`          | Quick save                      |
| `<leader><leader>` | Normal |                   | Find files                      |

### File Operations

| Key          | Mode   | Action | Description                    |
| ------------ | ------ | ------ | ------------------------------ |
| `<leader>ff` | Normal |        | Find files                     |
| `<leader>fg` | Normal |        | Find text in files             |
| `<leader>fc` | Normal |        | Find in code (no tests)        |
| `<leader>fr` | Normal |        | Find recent files              |
| `<leader>fs` | Normal |        | Save file                      |
| `<leader>fw` | Normal |        | Save all files                 |
| `<leader>fk` | Normal |        | Find keymaps                   |
| `<leader>/`  | Normal |        | Fuzzy search in current buffer |
| `<leader>fb` | Normal |        | Find open buffers              |

### K9s and Kubernetes Operations

| Key           | Mode   | Action | Description                       |
| ------------- | ------ | ------ | --------------------------------- |
| `<leader>k9`  | Normal |        | Launch K9s                        |
| `<leader>k9v` | Normal |        | Launch K9s in vertical split      |
| `<leader>k9h` | Normal |        | Launch K9s in horizontal split    |
| `<leader>kc`  | Normal |        | Change Kubernetes context         |
| `<leader>kn`  | Normal |        | Change Kubernetes namespace       |
| `<leader>kp`  | Normal |        | View pods in K9s                  |
| `<leader>kd`  | Normal |        | View deployments in K9s           |
| `<leader>ks`  | Normal |        | View services in K9s              |
| `<leader>kl`  | Normal |        | View logs for resource            |
| `<leader>kL`  | Normal |        | View logs for resource in file    |
| `<leader>kf`  | Normal |        | Port forward service from file    |
| `<leader>ka`  | Normal |        | Apply current k8s manifest        |
| `<leader>kD`  | Normal |        | Delete resource from current file |
| `<leader>kg`  | Normal |        | Generate kubernetes YAML template |

### Buffer Operations

| Key          | Mode   | Action | Description     |
| ------------ | ------ | ------ | --------------- |
| `<leader>bf` | Normal |        | Buffer list     |
| `<leader>bn` | Normal |        | Next buffer     |
| `<leader>bp` | Normal |        | Previous buffer |
| `<leader>bd` | Normal |        | Delete buffer   |

### Code & LSP Operations

| Key          | Mode   | Action | Description            |
| ------------ | ------ | ------ | ---------------------- |
| `<leader>ca` | Normal |        | Code actions           |
| `<leader>cf` | Normal |        | Format code            |
| `<leader>cr` | Normal |        | Rename symbol          |
| `<leader>ci` | Normal |        | Code info/hover        |
| `K`          | Normal |        | Show hover information |
| `<leader>gd` | Normal |        | Go to definition       |
| `<leader>gr` | Normal |        | Go to references       |
| `<leader>mp` | Normal |        | Format with conform    |

### Harpoon File Navigation

| Key          | Mode   | Action | Description           |
| ------------ | ------ | ------ | --------------------- |
| `<leader>ha` | Normal |        | Add file to harpoon   |
| `<leader>he` | Normal |        | View harpoon menu     |
| `<leader>h1` | Normal |        | Jump to harpoon 1     |
| `<leader>h2` | Normal |        | Jump to harpoon 2     |
| `<leader>h3` | Normal |        | Jump to harpoon 3     |
| `<leader>h4` | Normal |        | Jump to harpoon 4     |
| `<A-j>`      | Normal |        | Next harpoon file     |
| `<A-k>`      | Normal |        | Previous harpoon file |
| `<leader>hf` | Normal |        | Find harpoon files    |

### Flash.nvim Navigation

| Key          | Mode             | Description                 |
| ------------ | ---------------- | --------------------------- |
| `s`          | Normal,Visual,Op | Flash jump anywhere         |
| `S`          | Normal,Visual,Op | Jump to treesitter node     |
| `r`          | Operator         | Remote flash operation      |
| `R`          | Operator,Visual  | Treesitter search           |
| `<leader>js` | Normal           | Jump to line start          |
| `<leader>je` | Normal           | Jump to line end            |
| `<leader>jw` | Normal           | Jump to exact word          |
| `<leader>jf` | Normal           | Jump to function definition |
| `<leader>jc` | Normal           | Jump to comment             |

### AI Assistant (Claude)

| Key          | Mode   | Action | Description                   |
| ------------ | ------ | ------ | ----------------------------- |
| `<leader>aa` | Normal |        | New Avante chat               |
| `<leader>ac` | Normal |        | Avante Clear                  |
| `<leader>af` | Normal |        | Avante Focus                  |
| `<leader>at` | Normal |        | Toggle Avante                 |
| `<leader>am` | Normal |        | Avante Models                 |
| `<leader>as` | Visual |        | Ask Avante about selection    |
| `<leader>ai` | Visual |        | Improve selection with Avante |
| `<leader>ae` | Visual |        | Explain selection with Avante |

### Diagnostics & Trouble

| Key          | Mode   | Action | Description             |
| ------------ | ------ | ------ | ----------------------- |
| `[d`         | Normal |        | Previous diagnostic     |
| `]d`         | Normal |        | Next diagnostic         |
| `<leader>e`  | Normal |        | Show diagnostic message |
| `<leader>q`  | Normal |        | Open diagnostic list    |
| `<leader>xx` | Normal |        | Toggle Trouble          |
| `<leader>xw` | Normal |        | Workspace diagnostics   |
| `<leader>xd` | Normal |        | Document diagnostics    |
| `<leader>xq` | Normal |        | Quickfix list           |
| `<leader>xl` | Normal |        | Location list           |

### Git Operations

| Key          | Mode           | Action | Description         |
| ------------ | -------------- | ------ | ------------------- |
| `<leader>gb` | Normal         |        | Git blame line      |
| `<leader>gB` | Normal, Visual |        | Git browse          |
| `<leader>gh` | Normal         |        | Git file history    |
| `<leader>gg` | Normal         |        | Lazygit             |
| `<leader>gl` | Normal         |        | Git log             |
| `<leader>gc` | Normal         |        | Git commits         |
| `<leader>gf` | Normal         |        | Git buffer commits  |
| `<leader>gi` | Normal         |        | Advanced Git search |

### UI Toggles

| Key          | Mode   | Action | Description             |
| ------------ | ------ | ------ | ----------------------- |
| `<leader>us` | Normal |        | Toggle spelling         |
| `<leader>uw` | Normal |        | Toggle word wrap        |
| `<leader>uL` | Normal |        | Toggle relative numbers |
| `<leader>ud` | Normal |        | Toggle diagnostics      |
| `<leader>ul` | Normal |        | Toggle line numbers     |
| `<leader>uc` | Normal |        | Toggle conceal          |
| `<leader>uT` | Normal |        | Toggle treesitter       |
| `<leader>ub` | Normal |        | Toggle background       |
| `<leader>uh` | Normal |        | Toggle inlay hints      |
| `<leader>ug` | Normal |        | Toggle indent guides    |
| `<leader>uD` | Normal |        | Toggle dim mode         |
| `<leader>uC` | Normal |        | Color picker            |

### Window Operations

| Key          | Mode   | Action | Description            |
| ------------ | ------ | ------ | ---------------------- |
| `<leader>wv` | Normal |        | Split vertically       |
| `<leader>ws` | Normal |        | Split horizontally     |
| `<leader>w=` | Normal |        | Equal window width     |
| `<leader>w+` | Normal |        | Increase window height |
| `<leader>w-` | Normal |        | Decrease window height |
| `<leader>w>` | Normal |        | Increase window width  |
| `<leader>w<` | Normal |        | Decrease window width  |

## Options

### Basic Settings

- Space as leader key
- Line numbers with relative numbering
- 2-space indentation with soft tabs
- No line wrapping
- Mouse enabled for all modes
- System clipboard integration
- Improved search (case-insensitive unless capital letters used)
- Split windows open to the right and below
- Visible whitespace characters
- Live preview for substitutions
- Highlighted cursor line and column
- Scrolloff of 10 lines
- No swap files
- True color support
- Auto-reload files when modified externally

### FZF Configuration

FZF is configured with several customizations:

- Wrapped text in search queries and preview window
- Support for ripgrep globbing
- Customized display settings without icons
- File path formatting set to filename first

### Lualine Configuration

The status line is configured using Lualine with several custom components:

- Abbreviated mode display (N for Normal, I for Insert, etc.)
- Git status with branch and change indicators
- Diagnostics from LSP
- File name with modification indicators
- Word count for text and markdown files
- Search and selection count
- Macro recording indicator
- Scroll position indicator
- Custom styling and separators

### Snippet Management

Custom snippets are stored in `~/git/snippets/` and organized by filetype:

- Use `:SnippetEdit` to create/edit snippets for the current filetype
- Use `:SnippetEdit <filetype>` for a specific language
- Snippet navigation with `<C-k>` to expand/jump forward and `<C-j>` to jump backward
- Language-specific snippets for Lua, Go, Terraform, Helm, and Rust

## Features

### Language Server Protocol (LSP)

- Automatic installation of language servers via Mason
- Preconfigured for multiple languages (Go, Lua, Python, etc.)
- Integration with completion, formatting, and diagnostics
- Customizable through Mason configuration

### Treesitter

- Syntax highlighting for numerous languages
- Code folding based on syntax
- Text objects for selecting code blocks
- Code navigation between functions and classes

### Debugging

- Debug adapters for multiple languages
- Customizable UI for debugging
- Breakpoints, stepping, and variable inspection
- Integration with Mason for easy installation of debug adapters

### AI Integration

- [Avante](https://github.com/yetone/avante.nvim) for Claude AI assistant integration
- Visual mode selections for code improvement, explanation, and assistance
- Dedicated keybindings for AI interactions

### Project-Specific Settings

- Supports per-project configuration via `.nvim.lua` files in project roots
- Automatically applies project-specific settings when opening files
- Allows custom formatters, linters, and keymaps per project

## K9s Integration

The K9s integration provides a seamless DevOps workflow between Neovim and Kubernetes.

### Features

- Launch K9s directly from Neovim with context awareness
- Intelligent split views for code editing and cluster management
- Execute Kubernetes operations on resources from the current file
- Automatic context and namespace detection
- View logs in a split window
- Port forwarding for services
- Apply, delete, and scale resources directly from manifest files

### Commands

- `:K9s` - Launch K9s with current context and namespace
- `:K9s context` or `:K9s ctx` - Select a context and launch K9s
- `:K9s namespace` or `:K9s ns` - Select a namespace and launch K9s
- `:K9s file` or `:K9s f` - Parse current file and launch K9s for that resource
- `:K9s pods|deployments|services|...` - Launch K9s focused on specific resource type
- `:K9sLogs [resource-type/name]` - Display and follow logs for a resource

### Kubernetes Snippets

The package includes numerous snippets for Kubernetes resources:

| Trigger          | Description                          |
| ---------------- | ------------------------------------ |
| `kdeployment`    | Create a deployment                  |
| `kservice`       | Create a service                     |
| `kconfigmap`     | Create a configmap                   |
| `ksecret`        | Create a secret                      |
| `kingress`       | Create an ingress                    |
| `kstatefulset`   | Create a statefulset                 |
| `kpvc`           | Create a persistent volume claim     |
| `kjob`           | Create a job                         |
| `kcronjob`       | Create a cronjob                     |
| `knamespace`     | Create a namespace                   |
| `kcontainer`     | Add a container to a pod template    |
| `kenv`           | Add environment variables            |
| `kvolume`        | Add a volume                         |
| `kvolumemount`   | Add a volume mount                   |
| `klivenessprobe` | Add a liveness probe                 |
| `khpa`           | Create a horizontal pod autoscaler   |
| `knetworkpolicy` | Create a network policy              |
| `kmetadata`      | Add a comprehensive metadata section |
| `kclusterinfo`   | Insert current cluster context info  |

## Recent Improvements

### Performance Optimizations

- **Improved Scrolling Performance**: Optimized Lualine with caching and scroll detection
- **Reduced CPU Usage**: Removed CPU monitoring from status line
- **Enhanced Autocommands**: Reorganized autocommands with better grouping and descriptions
- **Smart Formatting**: Added quiet format-on-save with formatter availability detection

### Navigation Enhancements

- **Harpoon Integration**: Quick navigation between frequently used files
- **Flash.nvim Configuration**: Enhanced motions for faster code navigation
- **Custom Jump Commands**: Special jumps to line start/end, functions, and comments

### DevOps Enhancements

- **K9s Integration**: Seamless Kubernetes management from within Neovim
- **Kubernetes Snippets**: Context-aware snippets for faster authoring of K8s resources
- **Enhanced TMUX Integration**: Better terminal handling for DevOps workflows

### Productivity Features

- **Custom Snippet System**:

  - Snippets stored in git repository for version control
  - Organized by language with tailored snippets for Go, Terraform, Helm, and Rust
  - Easy editing via `:SnippetEdit` command

- **Project Settings**:
  - Project-specific configurations via `.nvim.lua` files
  - Supports custom LSP settings, formatters, and keymaps per project

### UI Improvements

- **Which-Key Enhancements**: Better organization and visual indicators for keymaps
- **Icon Integration**: Comprehensive icons for different types of operations
- **Enhanced Statusline**: Optimized statusline with smart component updates

### Upcoming Improvements

See the [Neovim Configuration Improvements](~/git/nvim-improvements.md) document for upcoming enhancements.
