return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		})
	end,
}

--return {
--	"akinsho/bufferline.nvim",
--	event = "VeryLazy",
--	dependencies = { "nvim-tree/nvim-web-devicons" },
--	version = "*",
--	opts = {
--		options = {
--			mode = "tabs",
--			separator_style = "slant",
--			show_close_icon = false,
--			show_buffer_close_icons = false,
--			diagnostics = "nvim_lsp",
--			-- show_tab_indicators = true,
--			-- enforce_regular_tabs = true,
--			always_show_bufferline = true,
--			-- indicator = {
--			-- 	style = 'underline',
--			-- },
--			custom_areas = {
--				right = function()
--					local result = {}
--					local root = LazyVim.root()
--					table.insert(result, {
--						text = "%#BufferLineTab# " .. vim.fn.fnamemodify(root, ":t"),
--					})
--
--					-- Session indicator
--					if vim.v.this_session ~= "" then
--						table.insert(result, { text = "%#BufferLineTab#  " })
--					end
--					return result
--				end,
--			},
--			offsets = {
--				{
--					filetype = "neo-tree",
--					text = "Neo-tree",
--					highlight = "Directory",
--					text_align = "center",
--				},
--			},
--		},
--	},
--	config = function(_, opts)
--		require("bufferline").setup(opts)
--		-- Fix bufferline when restoring a session
--		vim.api.nvim_create_autocmd("BufAdd", {
--			callback = function()
--				vim.schedule(function()
--					---@diagnostic disable-next-line: undefined-global
--					pcall(nvim_bufferline)
--				end)
--			end,
--		})
--	end,
--}
