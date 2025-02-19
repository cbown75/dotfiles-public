function get_setup(name)
	return function()
		require("setup." .. name)
	end
end

return {
	{ "mbbill/undotree" },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon supported
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = get_setup("fzf"),
	},
	{
		"nvim-lualine/lualine.nvim",
		config = get_setup("lualine"),
		event = "VeryLazy",
	},
}
