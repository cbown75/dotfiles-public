return {
	"folke/noice.nvim",
	lazy = false,
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			cmdline = {
				view = "cmdline_popup",
			},
			views = {
				cmdline_popup = {
					size = {
						height = "auto",
						width = "60%",
					},
					position = {
						row = "50%",
						col = "50%",
					},
					border = {
						style = "single",
					},
				},
			},
		})
	end,
}
