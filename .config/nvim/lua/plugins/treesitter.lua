return {
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"javascript",
					"typescript",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"elixir",
					"erlang",
					"heex",
					"eex",
					"java",
					"kotlin",
					"latex",
					"css",
					"norg",
					"scss",
					"svelte",
					"typst",
					"vue",
					"jq",
					"dockerfile",
					"json",
					"html",
					"terraform",
					"go",
					"tsx",
					"bash",
					"ruby",
					"markdown",
					"java",
					"regex",
					"yaml",
					"hcl",
					"python",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-CR>",
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>Pi"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>Ps"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
