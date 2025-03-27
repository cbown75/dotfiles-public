return {
	"ThePrimeagen/harpoon",
	-- Remove the branch specification to use the stable v1 version
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Use the stable v1 API
		require("harpoon").setup({
			global_settings = {
				-- Disable global keymaps
				save_on_change = true,
				mark_branch = false,
			},
			-- Disable menu UI settings to avoid serialization issues
			menu = {
				width = 60,
				height = 10,
			},
		})
	end,
}
