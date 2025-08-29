-- ~/.config/nvim/lua/config/options.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("set modifiable")
vim.cmd("set softtabstop=2")

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes:1"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- disable swapfiles
vim.opt.swapfile = false

vim.opt.termguicolors = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- auto-reload files when modified externally
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- DevOps related options
-- Set formatoptions for DevOps-related filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "terraform", "yaml", "json", "dockerfile", "helm" },
	callback = function()
		vim.opt_local.formatoptions:append("r") -- Auto insert comment leader on <Enter>
		vim.opt_local.formatoptions:append("o") -- Auto insert comment leader on 'o' or 'O'
		vim.opt_local.formatoptions:append("j") -- Remove comment leader when joining lines
	end,
})

-- Terraform options
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "terraform", "hcl" },
	callback = function()
		vim.opt_local.commentstring = "# %s"
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- YAML options
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "yaml", "yaml.kubernetes", "yaml.helm" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.commentstring = "# %s"
	end,
})

-- Docker options
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "dockerfile" },
	callback = function()
		vim.opt_local.commentstring = "# %s"
	end,
})
