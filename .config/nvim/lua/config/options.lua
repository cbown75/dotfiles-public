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

-- Safe patches for deprecated APIs - applied in a deferred manner
-- to avoid conflicts with core Neovim functions during startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Fix vim.highlight deprecation (safe approach)
		if vim.highlight and not vim._highlight_patched then
			local orig_range = vim.highlight.range
			vim.highlight.range = function(bufnr, ns_id, hlgroup, start_pos, end_pos, priority)
				-- Use the new API
				if vim.hl and vim.hl.range then
					return vim.hl.range(bufnr, ns_id, hlgroup, start_pos, end_pos, { priority = priority })
				else
					-- Fallback to the original function if the new API isn't available
					return orig_range(bufnr, ns_id, hlgroup, start_pos, end_pos, priority)
				end
			end
			vim._highlight_patched = true
		end

		-- Fix vim.str_utfindex deprecation (safe approach)
		if vim.str_utfindex and not vim._str_utfindex_patched then
			local orig_str_utfindex = vim.str_utfindex
			vim.str_utfindex = function(s, idx, use_utf16)
				if type(idx) == "number" then
					-- Try the new API format
					local ok, result = pcall(orig_str_utfindex, s, use_utf16 and "utf-16" or "utf-8", idx, false)
					if ok then
						return result
					else
						-- Fallback to original behavior if new format fails
						return orig_str_utfindex(s, idx, use_utf16)
					end
				else
					-- Already in the new format or unknown format, pass through
					return orig_str_utfindex(s, idx, use_utf16)
				end
			end
			vim._str_utfindex_patched = true
		end

		-- NOTE: We don't patch vim.validate to avoid the startup error
		-- It's better to let the plugin authors update their code
	end,
	once = true,
})
