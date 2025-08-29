return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		-- Add explicit configuration to prevent module loading issues
		file_types = { "markdown" },
		render_modes = { "n", "c", "i" },
		anti_conceal = {
			enabled = true,
		},
	},
	-- Pin to a stable version to avoid module loading issues
	version = "v8.7.15",
}
