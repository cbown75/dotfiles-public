# Neovim Configuration

A comprehensive and modular Neovim configuration with carefully selected plugins and keymappings to enhance productivity.

## Table of Contents

- [Installation](#installation)
- [Structure](#structure)
- [Plugins](#plugins)
- [Keymaps](#keymaps)
- [Options](#options)
- [Features](#features)

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
