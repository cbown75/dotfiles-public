return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"javascript",
				"typescript",
				"tsx",
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
				"bash",
				"ruby",
				"markdown",
				"markdown_inline",
				"regex",
				"yaml",
				"hcl",
				"python",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Enable treesitter highlighting if a parser exists
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			-- Select textobjects
			vim.keymap.set({ "x", "o" }, "af", function() select("@function.outer", "textobjects") end, { desc = "outer function" })
			vim.keymap.set({ "x", "o" }, "if", function() select("@function.inner", "textobjects") end, { desc = "inner function" })
			vim.keymap.set({ "x", "o" }, "ac", function() select("@class.outer", "textobjects") end, { desc = "outer class" })
			vim.keymap.set({ "x", "o" }, "ic", function() select("@class.inner", "textobjects") end, { desc = "inner class" })
			vim.keymap.set({ "x", "o" }, "aa", function() select("@parameter.outer", "textobjects") end, { desc = "outer parameter" })
			vim.keymap.set({ "x", "o" }, "ia", function() select("@parameter.inner", "textobjects") end, { desc = "inner parameter" })

			-- Move to next/prev function/class
			vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
			vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end, { desc = "Next class end" })
			vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
			vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
			vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
			vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end, { desc = "Prev class end" })

			-- Swap parameters
			vim.keymap.set("n", "<leader>Pi", function() swap.swap_next("@parameter.inner") end, { desc = "Swap param next" })
			vim.keymap.set("n", "<leader>Ps", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap param prev" })
		end,
	},
}
