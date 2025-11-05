return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			pane_gap = 1,  -- reduce space between panes (default is 4)
			sections = {
				{
					pane = 1,
					{
						section = "terminal",
						cmd = "chafa ~/.config/nvim/herbie_husker_logo.png --format symbols --symbols vhalf --size 30x43 --clear; sleep .1",
						height = 43,
						padding = 1,
						align = "center",
					},
				},
				{
					pane = 2,
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		words = { enabled = true },
		lazygit = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				_G.toggle_spelling = Snacks.toggle.option("spell", { name = "Spelling" })
				_G.toggle_wrap = Snacks.toggle.option("wrap", { name = "Wrap" })
				_G.toggle_relative_number = Snacks.toggle.option("relativenumber", { name = "Relative Number" })
				_G.toggle_diagnostics = Snacks.toggle.diagnostics()
				_G.toggle_line_number = Snacks.toggle.line_number()
				_G.toggle_conceal = Snacks.toggle.option(
					"conceallevel",
					{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
				)
				_G.toggle_treesitter = Snacks.toggle.treesitter()
				_G.toggle_background =
						Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" })
				_G.toggle_inlay_hints = Snacks.toggle.inlay_hints()
				_G.toggle_indent = Snacks.toggle.indent()
				_G.toggle_dim = Snacks.toggle.dim()
			end,
		})
	end,
}
