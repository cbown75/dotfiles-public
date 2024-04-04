local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "plugins" } },
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	defaults = {
		lazy = false,
	},
	install = { colorscheme = { "catppuccin", "catppuccin-mocha" } },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--if not vim.loop.fs_stat(lazypath) then
--  -- stylua: ignore
--  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
--end
--vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
--
--require("lazy").setup({
--	spec = {
--		-- add LazyVim and import its plugins
--		{
--			"LazyVim/LazyVim",
--			import = "lazyvim.plugins",
--			opts = {
--				news = {
--					lazyvim = true,
--					neovim = true,
--				},
--			},
--		},
--		{ import = "lazyvim.plugins.extras.lsp.none-ls" },
--		{ import = "plugins" },
--	},
--	defaults = {
--		lazy = false,
--	},
--	install = { colorscheme = { "catppuccin", "catppuccin-mocha" } },
--	checker = { enabled = true },
--	performance = {
--		cache = {
--			enabled = true,
--		},
--		rtp = {
--			-- disable some rtp plugins
--			disabled_plugins = {
--				"gzip",
--				-- "matchit",
--				-- "matchparen",
--				-- "netrwPlugin",
--				"rplugin",
--				"tarPlugin",
--				"tohtml",
--				"tutor",
--				"zipPlugin",
--			},
--		},
--	},
--})
