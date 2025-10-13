return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets", -- Community snippet collection
		"saadparwaiz1/cmp_luasnip", -- Integration with nvim-cmp
	},
	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		-- Load friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Load your custom snippets from ~/git/snippets
		require("luasnip.loaders.from_lua").load({ paths = vim.fn.expand("~/git/snippets/") })

		-- Rest of configuration remains the same
		luasnip.config.set_config({
			-- Enable autotriggered snippets
			enable_autosnippets = true,

			-- For dynamic snippets update as you type
			updateevents = "TextChanged,TextChangedI",

			-- Customize how snippets look in the editor
			ext_opts = {
				[types.insertNode] = {
					active = {
						virt_text = { { "●", "GruvboxOrange" } },
					},
				},
				[types.choiceNode] = {
					active = {
						virt_text = { { "≡", "GruvboxBlue" } },
					},
				},
			},
		})

		-- Global helpers remain the same
		_G.luasnip_helpers = {
			-- The helper functions remain the same
			-- ...
		}
	end,
}
