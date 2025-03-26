# Neovim Configuration

A custom Neovim configuration with carefully selected plugins and keymappings to enhance productivity.

## Table of Contents

- [Installation](#installation)
- [Structure](#structure)
- [Plugins](#plugins)
- [Keymaps](#keymaps)
- [Options](#options)
- [Icons](#icons)

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
- `config/keymaps.lua`: Key mappings
- `plugins/*.lua`: Individual plugin definitions and configurations
- `icons.lua`: Icon definitions for UI elements

## Plugins

The configuration uses [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Here are the included plugins:

| Plugin                                                                                                    | Description                              |
| --------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| [mbbill/undotree](https://github.com/mbbill/undotree)                                                     | Visualize and browse undo history        |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)                                                   | Fuzzy finder integration                 |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                                 | Status line                              |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                             | Icons for UI elements                    |
| [yetone/avante.nvim](https://github.com/yetone/avante.nvim)                                               | AI assistant integration (Claude)        |
| [utilyre/barbecue.nvim](https://github.com/utilyre/barbecue.nvim)                                         | VS Code-like winbar context              |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                                     | Buffer line with tabpage integration     |
| [binhtran432k/dracula.nvim](https://github.com/binhtran432k/dracula.nvim)                                 | Dracula colorscheme                      |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                                   | Completion engine                        |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                                   | Snippet engine                           |
| [folke/flash.nvim](https://github.com/folke/flash.nvim)                                                   | Enhanced navigation and search           |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)                                         | Code formatting                          |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)                                     | Package manager for LSP/DAP/linters      |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                         | LSP configuration                        |
| [vhyrro/luarocks.nvim](https://github.com/vhyrro/luarocks.nvim)                                           | Luarocks package manager                 |
| [echasnovski/mini.icons](https://github.com/echasnovski/mini.icons)                                       | Icons for UI                             |
| [echasnovski/mini.indentscope](https://github.com/echasnovski/mini.indentscope)                           | Visual indentation guides                |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                             | File explorer                            |
| [AckslD/nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                     | Clipboard manager                        |
| [folke/noice.nvim](https://github.com/folke/noice.nvim)                                                   | UI for messages, cmdline and popupmenu   |
| [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)                                       | Diagnostics, formatting, and more        |
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)                                         | Debug Adapter Protocol client            |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)                                           | UI for nvim-dap                          |
| [nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre)                                       | Search and replace across files          |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                                         | Lua utility functions                    |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown previewer                       |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim)                                                 | Collection of small utility features     |
| [tpope/vim-surround](https://github.com/tpope/vim-surround)                                               | Surround text with pairs                 |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                         | Fuzzy finder framework                   |
| [nathom/tmux.nvim](https://github.com/nathom/tmux.nvim)                                                   | Tmux integration                         |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                                   | Highlight and search TODO comments       |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                     | Parser generator and syntax highlighting |
| [folke/trouble.nvim](https://github.com/folke/trouble.nvim)                                               | A diagnostics panel                      |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                                               | Git integration                          |
| [tpope/vim-projectionist](https://github.com/tpope/vim-projectionist)                                     | Project configuration                    |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim)                                           | Display key bindings                     |
| [SmiteshP/nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy)                                       | Code navigation popup                    |

## Keymaps

### General

| Key          | Mode     | Action            | Description              |
| ------------ | -------- | ----------------- | ------------------------ |
| `<Space>`    | All      | Leader key        | Global leader key        |
| `<Esc>`      | Normal   | `:nohlsearch<CR>` | Clear search highlights  |
| `jj`         | Insert   | `<Esc>`           | Exit insert mode         |
| `<C-k>`      | Normal   | `:wincmd k<CR>`   | Navigate to window above |
| `<C-j>`      | Normal   | `:wincmd j<CR>`   | Navigate to window below |
| `<C-h>`      | Normal   | `:wincmd h<CR>`   | Navigate to window left  |
| `<C-l>`      | Normal   | `:wincmd l<CR>`   | Navigate to window right |
| `<leader>h`  | Normal   | `:nohlsearch<CR>` | Clear search highlights  |
| `<leader>nh` | Normal   | `:nohl<CR>`       | Clear search highlights  |
| `<Esc><Esc>` | Terminal | `<C-\><C-n>`      | Exit terminal mode       |

### Plugin Management

| Key          | Mode   | Action             | Description              |
| ------------ | ------ | ------------------ | ------------------------ |
| `<leader>lu` | Normal | `:Lazy update<CR>` | Update plugins with Lazy |

### Navigation and Window Management

| Key          | Mode   | Action              | Description                    |
| ------------ | ------ | ------------------- | ------------------------------ |
| `<left>`     | Normal | Error message       | Reminder to use 'h' to move    |
| `<right>`    | Normal | Error message       | Reminder to use 'l' to move    |
| `<up>`       | Normal | Error message       | Reminder to use 'k' to move    |
| `<down>`     | Normal | Error message       | Reminder to use 'j' to move    |
| `<leader>to` | Normal | `<cmd>tabnew<CR>`   | Open new tab                   |
| `<leader>tx` | Normal | `<cmd>tabclose<CR>` | Close current tab              |
| `<leader>tn` | Normal | `<cmd>tabn<CR>`     | Go to next tab                 |
| `<leader>tp` | Normal | `<cmd>tabp<CR>`     | Go to previous tab             |
| `<leader>tf` | Normal | `<cmd>tabnew %<CR>` | Open current buffer in new tab |

### Clipboard Operations

| Key          | Mode           | Action | Description                                 |
| ------------ | -------------- | ------ | ------------------------------------------- |
| `<leader>y`  | Normal, Visual | `"+y`  | Yank to system clipboard                    |
| `<leader>Y`  | Normal, Visual | `"+Y`  | Yank line to system clipboard               |
| `<leader>dd` | Normal, Visual | `"+d`  | Delete to system clipboard                  |
| `<leader>DD` | Normal, Visual | `"+D`  | Delete line to system clipboard             |
| `<leader>p`  | Normal         | `"+p`  | Paste from system clipboard (after cursor)  |
| `<leader>P`  | Normal         | `"+P`  | Paste from system clipboard (before cursor) |

### Diagnostics and LSP

| Key         | Mode   | Action                      | Description                    |
| ----------- | ------ | --------------------------- | ------------------------------ |
| `[d`        | Normal | `vim.diagnostic.goto_prev`  | Go to previous diagnostic      |
| `]d`        | Normal | `vim.diagnostic.goto_next`  | Go to next diagnostic          |
| `<leader>e` | Normal | `vim.diagnostic.open_float` | Show diagnostic error messages |
| `<leader>q` | Normal | `vim.diagnostic.setloclist` | Open diagnostic quickfix list  |

### Utility Features

| Key          | Mode   | Action                            | Description         |
| ------------ | ------ | --------------------------------- | ------------------- |
| `<leader>xd` | Normal | `date()` function                 | Insert current date |
| `<leader>xu` | Normal | `:UndotreeToggle<cr>`             | Toggle undo tree    |
| `<leader>xb` | Normal | `require('nvim-navbuddy').open()` | Open Nav Buddy      |

### Avante AI (Claude) Integration

| Key          | Mode   | Action                                  | Description                   |
| ------------ | ------ | --------------------------------------- | ----------------------------- |
| `<leader>aa` | Normal | `:avantechatnew<cr>`                    | New Avante chat               |
| `<leader>at` | Normal | `:avantetoggle<cr>`                     | Toggle Avante                 |
| `<leader>as` | Visual | `require("avante").selection()`         | Ask Avante about selection    |
| `<leader>ai` | Visual | `require("avante").improve_selection()` | Improve selection with Avante |
| `<leader>ae` | Visual | `require("avante").explain_selection()` | Explain selection with Avante |

### Formatting and LSP

| Key          | Mode           | Action                    | Description              |
| ------------ | -------------- | ------------------------- | ------------------------ |
| `<leader>mp` | Normal, Visual | `conform.format()`        | Format file or selection |
| `<leader>gf` | Normal         | `vim.lsp.buf.format`      | Format file              |
| `K`          | Normal         | `vim.lsp.buf.hover`       | Show hover information   |
| `<leader>gd` | Normal         | `vim.lsp.buf.definition`  | Go to definition         |
| `<leader>gr` | Normal         | `vim.lsp.buf.references`  | Find references          |
| `<leader>ca` | Normal         | `vim.lsp.buf.code_action` | Code actions             |

### Debugging (DAP)

| Key          | Mode           | Action                     | Description                   |
| ------------ | -------------- | -------------------------- | ----------------------------- |
| `<leader>dB` | Normal         | Set conditional breakpoint | Add breakpoint with condition |
| `<leader>db` | Normal         | Toggle breakpoint          | Toggle breakpoint at line     |
| `<leader>dc` | Normal         | Continue                   | Run/Continue debugging        |
| `<leader>da` | Normal         | Run with args              | Run with arguments            |
| `<leader>dC` | Normal         | Run to cursor              | Run to cursor position        |
| `<leader>dg` | Normal         | Go to line                 | Go to line (no execute)       |
| `<leader>di` | Normal         | Step into                  | Step into function            |
| `<leader>dj` | Normal         | Go down                    | Move down in stack            |
| `<leader>dk` | Normal         | Go up                      | Move up in stack              |
| `<leader>dl` | Normal         | Run last                   | Run last configuration        |
| `<leader>do` | Normal         | Step out                   | Step out of function          |
| `<leader>dO` | Normal         | Step over                  | Step over                     |
| `<leader>dP` | Normal         | Pause                      | Pause execution               |
| `<leader>dr` | Normal         | Toggle REPL                | Toggle debug REPL             |
| `<leader>ds` | Normal         | Session                    | Show session info             |
| `<leader>dt` | Normal         | Terminate                  | Terminate session             |
| `<leader>du` | Normal         | Toggle UI                  | Toggle DAP UI                 |
| `<leader>dw` | Normal         | Widgets                    | Show debug widgets            |
| `<leader>de` | Normal, Visual | Evaluate                   | Evaluate expression           |

### Flash Navigation

| Key     | Mode                     | Action              | Description                |
| ------- | ------------------------ | ------------------- | -------------------------- |
| `s`     | Normal, Visual, Operator | Flash jump          | Quick navigation           |
| `S`     | Normal, Visual, Operator | Flash treesitter    | Jump with treesitter nodes |
| `r`     | Operator                 | Flash remote        | Remote flash               |
| `R`     | Visual, Operator         | Treesitter search   | Search with treesitter     |
| `<c-s>` | Command                  | Toggle flash search | Toggle flash search        |

### Noice UI

| Key           | Mode           | Action           | Description                        |
| ------------- | -------------- | ---------------- | ---------------------------------- |
| `<S-Enter>`   | Command        | Redirect cmdline | Redirect command line              |
| `<leader>snl` | Normal         | Last message     | Show last message                  |
| `<leader>snh` | Normal         | Message history  | Show message history               |
| `<leader>sna` | Normal         | All messages     | Show all messages                  |
| `<leader>snd` | Normal         | Dismiss all      | Dismiss all messages               |
| `<c-f>`       | Insert, Normal | Scroll forward   | Scroll forward in hover/signature  |
| `<c-b>`       | Insert, Normal | Scroll backward  | Scroll backward in hover/signature |

### Neoclip (Clipboard Manager)

| Key         | Mode   | Action                   | Description            |
| ----------- | ------ | ------------------------ | ---------------------- |
| `<leader>o` | Normal | `:Telescope neoclip<CR>` | Open clipboard history |

### Telescope

| Key          | Mode   | Action                      | Description                    |
| ------------ | ------ | --------------------------- | ------------------------------ |
| `<leader>ff` | Normal | `find_files`                | Find files                     |
| `<leader>fg` | Normal | `live_grep_args`            | Live grep with args            |
| `<leader>fc` | Normal | `live_grep` (no tests)      | Live grep code (exclude tests) |
| `<leader>fb` | Normal | `buffers`                   | Find buffers                   |
| `<leader>fh` | Normal | `help_tags`                 | Find help tags                 |
| `<leader>fs` | Normal | `lsp_document_symbols`      | Find symbols                   |
| `<leader>fi` | Normal | `AdvancedGitSearch`         | Advanced Git search            |
| `<leader>fo` | Normal | `oldfiles`                  | Find recently opened files     |
| `<leader>fw` | Normal | `grep_string`               | Find word under cursor         |
| `<leader>fk` | Normal | `keymaps`                   | Find keymaps                   |
| `<leader>gc` | Normal | `git_commits`               | Search Git commits             |
| `<leader>gb` | Normal | `git_bcommits`              | Search Git commits for buffer  |
| `<leader>/`  | Normal | `current_buffer_fuzzy_find` | Fuzzy search in buffer         |
| `<leader>tu` | Normal | `Telescope undo`            | Navigate undo history          |
| `<leader>uC` | Normal | `Telescope colors`          | Color picker                   |

### Search and Replace

| Key          | Mode   | Action                      | Description                |
| ------------ | ------ | --------------------------- | -------------------------- |
| `<leader>sr` | Normal | `require("spectre").open()` | Replace in files (Spectre) |

### Tmux Integration

| Key     | Mode   | Action                         | Description             |
| ------- | ------ | ------------------------------ | ----------------------- |
| `<C-h>` | Normal | `require('tmux').move_left()`  | Move to left tmux pane  |
| `<C-j>` | Normal | `require('tmux').move_down()`  | Move to lower tmux pane |
| `<C-k>` | Normal | `require('tmux').move_up()`    | Move to upper tmux pane |
| `<C-l>` | Normal | `require('tmux').move_right()` | Move to right tmux pane |

### Todo Comments

| Key          | Mode   | Action                                       | Description                     |
| ------------ | ------ | -------------------------------------------- | ------------------------------- |
| `]t`         | Normal | `jump_next()`                                | Jump to next todo comment       |
| `[t`         | Normal | `jump_prev()`                                | Jump to previous todo comment   |
| `<leader>xt` | Normal | `:TodoTrouble<cr>`                           | Show todos in Trouble           |
| `<leader>xT` | Normal | `:TodoTrouble keywords=TODO,FIX,FIXME<cr>`   | Show todos/fixes in Trouble     |
| `<leader>st` | Normal | `:TodoTelescope<cr>`                         | Search todos in Telescope       |
| `<leader>sT` | Normal | `:TodoTelescope keywords=TODO,FIX,FIXME<cr>` | Search todos/fixes in Telescope |

### Treesitter

| Key          | Mode   | Action                          | Description              |
| ------------ | ------ | ------------------------------- | ------------------------ |
| `<C-space>`  | Normal | Initialize/increment selection  | Treesitter selection     |
| `<C-CR>`     | Normal | Scope incremental               | Increase selection scope |
| `<bs>`       | Normal | Node decremental                | Decrease selection scope |
| `]m`         | Normal | Jump to next function start     | Navigate functions       |
| `]M`         | Normal | Jump to next function end       | Navigate functions       |
| `[m`         | Normal | Jump to previous function start | Navigate functions       |
| `[M`         | Normal | Jump to previous function end   | Navigate functions       |
| `]]`         | Normal | Jump to next class start        | Navigate classes         |
| `][`         | Normal | Jump to next class end          | Navigate classes         |
| `[[`         | Normal | Jump to previous class start    | Navigate classes         |
| `[]`         | Normal | Jump to previous class end      | Navigate classes         |
| `<leader>pi` | Normal | Swap parameter with next        | Swap parameters          |
| `<leader>ps` | Normal | Swap parameter with previous    | Swap parameters          |

### Snacks Utilities

| Key          | Mode             | Action                       | Description                    |
| ------------ | ---------------- | ---------------------------- | ------------------------------ |
| `<leader>z`  | Normal           | Toggle Zen Mode              | Enter distraction-free mode    |
| `<leader>Z`  | Normal           | Toggle Zoom                  | Zoom current window            |
| `<leader>.`  | Normal           | Toggle Scratch Buffer        | Open scratch buffer            |
| `<leader>S`  | Normal           | Select Scratch Buffer        | Select from scratch buffers    |
| `<leader>n`  | Normal           | Show notification history    | View past notifications        |
| `<leader>bd` | Normal           | Delete Buffer                | Delete current buffer          |
| `<leader>cR` | Normal           | Rename File                  | Rename current file            |
| `<leader>gB` | Normal, Visual   | Git Browse                   | Browse Git repo in browser     |
| `<leader>gb` | Normal           | Git Blame Line               | Show Git blame for line        |
| `<leader>gf` | Normal           | Lazygit Current File History | Show file history              |
| `<leader>gg` | Normal           | Lazygit                      | Open Lazygit                   |
| `<leader>gl` | Normal           | Lazygit Log                  | Show Git log                   |
| `<leader>un` | Normal           | Dismiss Notifications        | Dismiss all notifications      |
| `<c-/>`      | Normal           | Toggle Terminal              | Open floating terminal         |
| `]]`         | Normal, Terminal | Next Reference               | Jump to next reference         |
| `[[`         | Normal, Terminal | Previous Reference           | Jump to previous reference     |
| `<leader>N`  | Normal           | Neovim News                  | Show Neovim news               |
| `<leader>us` | Normal           | Toggle Spelling              | Toggle spell checker           |
| `<leader>uw` | Normal           | Toggle Wrap                  | Toggle line wrapping           |
| `<leader>uL` | Normal           | Toggle Relative Number       | Toggle relative line numbers   |
| `<leader>ud` | Normal           | Toggle Diagnostics           | Toggle diagnostic display      |
| `<leader>ul` | Normal           | Toggle Line Number           | Toggle line numbers            |
| `<leader>uc` | Normal           | Toggle Conceal               | Toggle conceallevel            |
| `<leader>uT` | Normal           | Toggle Treesitter            | Toggle Treesitter highlighting |
| `<leader>ub` | Normal           | Toggle Dark Background       | Switch between light/dark      |
| `<leader>uh` | Normal           | Toggle Inlay Hints           | Toggle LSP inlay hints         |
| `<leader>ug` | Normal           | Toggle Indent                | Toggle indent guides           |
| `<leader>uD` | Normal           | Toggle Dim                   | Toggle dim mode                |

### Trouble (Diagnostics Panel)

| Key          | Mode   | Action                       | Description                |
| ------------ | ------ | ---------------------------- | -------------------------- |
| `<leader>xx` | Normal | Toggle Trouble               | Toggle trouble window      |
| `<leader>xw` | Normal | Toggle workspace diagnostics | Show workspace diagnostics |
| `<leader>xd` | Normal | Toggle document diagnostics  | Show document diagnostics  |
| `<leader>xq` | Normal | Toggle quickfix              | Show quickfix list         |
| `<leader>xl` | Normal | Toggle loclist               | Show location list         |
| `gR`         | Normal | Toggle LSP references        | Show LSP references        |

### File Explorer (Neo-tree)

| Key          | Mode   | Action                                | Description                     |
| ------------ | ------ | ------------------------------------- | ------------------------------- |
| `<C-n>`      | Normal | `:Neotree filesystem reveal left<CR>` | Open file explorer              |
| `<leader>bf` | Normal | `:Neotree buffers reveal float<CR>`   | Show buffers in floating window |

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

```lua
require("fzf-lua").setup({
  fzf_opts = { ["--wrap"] = true },
  grep = {
    rg_glob = true,
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      return (regex or query), flags
    end,
  },
  winopts = {
    preview = {
      wrap = "wrap",
    },
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    formatter = "path.filename_first",
  },
})
```

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

## Icons

The configuration includes a comprehensive set of icons for:

- Diagnostics
- Documents and folders
- Git indicators
- Code elements (functions, variables, etc.)
- Data types
- UI elements

These icons enhance the visual experience and provide better context in various Neovim UI components.
