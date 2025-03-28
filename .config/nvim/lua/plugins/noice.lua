return {
	"folke/noice.nvim",
	lazy = false,
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = false,
			command_palette = false,
			long_message_to_split = true,
			inc_rename = false,
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
	},
}
