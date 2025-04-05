return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- Use classic preset for most traditional setup
		preset = "classic",
		-- Delay before showing the popup
		delay = 200,
		-- Icons configuration
		icons = {
			breadcrumb = "»", -- symbol used in the command line area
			separator = "➜", -- symbol used between a key and its label
			group = "+", -- symbol prepended to a group
		},
		-- Popup window configuration
		win = {
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			border = "single",
			title = true,
			title_pos = "center",
			no_overlap = true, -- Prevent popup from overlapping with cursor
		},
		-- Layout configuration
		layout = {
			width = { min = 20 }, -- min width of the columns
			spacing = 3,       -- spacing between columns
		},
		-- Key behavior
		keys = {
			scroll_down = "<c-d>", -- scroll down in the popup
			scroll_up = "<c-u>", -- scroll up in the popup
		},
		-- Plugins configuration
		plugins = {
			marks = true,   -- shows marks on ' and `
			registers = true, -- shows registers on " in NORMAL or <C-r> in INSERT
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z=
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = true,  -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true,  -- default bindings on <c-w>
				nav = true,      -- misc bindings to work with windows
				z = true,        -- bindings for folds, spelling and others prefixed with z
				g = true,        -- bindings for prefixed with g
			},
		},
		show_help = true, -- show help message in the command line
		show_keys = true, -- show the currently pressed key and its label
		triggers = {
			-- Automatically setup triggers
			{ "<auto>", mode = "nxso" },
		},
		-- Icons for specific types of operations
		icons = {
			breadcrumb = "»", -- symbol used in the command line area
			separator = "➜", -- symbol used between a key and its label
			group = "+", -- symbol prepended to a group
			mappings = true, -- enable icons for mappings
			rules = {
				-- Primary groups
				{ pattern = "<leader>o", icon = { icon = "󰯺", color = "blue" } },
				{ pattern = "<leader>a", icon = { icon = "󱠁", color = "purple" } },
				{ pattern = "<leader>c", icon = { icon = "󰅱", color = "green" } },
				{ pattern = "<leader>f", icon = { icon = "󰈢", color = "yellow" } },
				{ pattern = "<leader>g", icon = { icon = "󰊢", color = "orange" } },
				{ pattern = "<leader>t", icon = { icon = "󰍉", color = "cyan" } },
				{ pattern = "<leader>u", icon = { icon = "󰒓", color = "purple" } },
				{ pattern = "<leader>w", icon = { icon = "󱂬", color = "blue" } },
				{ pattern = "<leader>x", icon = { icon = "󰁨", color = "red" } },

				-- DevOps tools and workflows
				{ pattern = "<leader>ok", icon = { icon = "󰠰", color = "blue" } }, -- Kubernetes
				{ pattern = "<leader>ot", icon = { icon = "󱁢", color = "purple" } }, -- Terraform
				{ pattern = "<leader>oa", icon = { icon = "󰸏", color = "orange" } }, -- AWS
				{ pattern = "<leader>od", icon = { icon = "󰡨", color = "blue" } }, -- Docker
				{ pattern = "<leader>op", icon = { icon = "󰌠", color = "yellow" } }, -- Python
				{ pattern = "<leader>oy", icon = { icon = "󰌹", color = "green" } }, -- YAML
				{ pattern = "<leader>oj", icon = { icon = "󰘦", color = "blue" } }, -- JSON
				{ pattern = "<leader>oe", icon = { icon = "󰯃", color = "purple" } }, -- Encoding
				{ pattern = "<leader>ob", icon = { icon = "󰯄", color = "purple" } }, -- Base64
				{ pattern = "<leader>ou", icon = { icon = "🔄", color = "blue" } }, -- URL
				{ pattern = "<leader>os", icon = { icon = "󰌘", color = "green" } }, -- SSH
				{ pattern = "<leader>ov", icon = { icon = "✓", color = "green" } }, -- Validation

				-- Resource-specific icons
				{ pattern = ".*pod.*", icon = { icon = "󰠳", color = "green" } },
				{ pattern = ".*deploy.*", icon = { icon = "󰄢", color = "blue" } },
				{ pattern = ".*service.*", icon = { icon = "󱏞", color = "purple" } },
				{ pattern = ".*ec2.*", icon = { icon = "󰯉", color = "orange" } },
				{ pattern = ".*s3.*", icon = { icon = "󰧺", color = "yellow" } },
				{ pattern = ".*lambda.*", icon = { icon = "λ", color = "cyan" } },

				-- AI and code operations
				{ pattern = "<leader>aa", icon = { icon = "󰭹", color = "green" } },
				{ pattern = "<leader>as", icon = { icon = "󰞋", color = "blue" } },
				{ pattern = "<leader>ai", icon = { icon = "󰃢", color = "green" } },
				{ pattern = "<leader>ca", icon = { icon = "󰛩", color = "yellow" } },
				{ pattern = "<leader>cf", icon = { icon = "󰁨", color = "blue" } },
				{ pattern = "<leader>co", icon = { icon = "📂", color = "yellow" } }, -- Code directory change

				-- Tmux and terminal
				{ pattern = "<leader>tm", icon = { icon = "󰓩", color = "blue" } },
				{ pattern = "<leader>tn", icon = { icon = "󰆍", color = "green" } },
				{ pattern = "<leader>tt", icon = { icon = "󰆍", color = "green" } },
			},
			colors = true,
		},
		-- Disable for certain filetypes
		disable = {
			ft = {},
			bt = {},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Define organized groups with appropriate icons and descriptions
		wk.add({
			-- Primary command groups
			{
				"<leader>o",
				group = "DevOps Tools",
				desc = "DevOps tools and operations",
				icon = { icon = "󰯺", color = "blue" },
			},
			{
				"<leader>a",
				group = "AI Assistant",
				desc = "AI assistance with Claude",
				icon = { icon = "󱠁", color = "purple" },
			},
			{
				"<leader>c",
				group = "Code",
				desc = "Code actions and editing",
				icon = { icon = "󰅱", color = "green" },
			},
			{
				"<leader>f",
				group = "File/Find",
				desc = "File operations and search",
				icon = { icon = "󰈢", color = "yellow" },
			},
			{
				"<leader>g",
				group = "Git",
				desc = "Git operations",
				icon = { icon = "󰊢", color = "orange" },
			},
			{
				"<leader>t",
				group = "Terminal/Tab",
				desc = "Terminal and tab operations",
				icon = { icon = "󰍉", color = "cyan" },
			},
			{
				"<leader>u",
				group = "UI Toggle",
				desc = "Toggle UI features",
				icon = { icon = "󰒓", color = "purple" },
			},
			{
				"<leader>w",
				group = "Window",
				desc = "Window management",
				icon = { icon = "󱂬", color = "blue" },
			},
			{
				"<leader>x",
				group = "Diagnostics",
				desc = "Diagnostics & trouble",
				icon = { icon = "󰁨", color = "red" },
			},
			{
				"<leader>s",
				group = "Search",
				desc = "Search operations",
				icon = { icon = "󱘧", color = "yellow" },
			},

			-- DevOps subgroups with more specific icons
			{
				"<leader>ok",
				group = "Kubernetes",
				desc = "Kubernetes operations",
				icon = { icon = "󰠰", color = "blue" },
			},
			{
				"<leader>ot",
				group = "Terraform",
				desc = "Terraform operations",
				icon = { icon = "󱁢", color = "purple" },
			},
			{
				"<leader>oa",
				group = "AWS",
				desc = "AWS operations",
				icon = { icon = "󰸏", color = "orange" },
			},
			{
				"<leader>od",
				group = "Docker",
				desc = "Docker operations",
				icon = { icon = "󰡨", color = "blue" },
			},
			{
				"<leader>op",
				group = "Python",
				desc = "Python operations",
				icon = { icon = "󰌠", color = "yellow" },
			},
			{
				"<leader>ov",
				group = "Validate",
				desc = "Validation commands",
				icon = { icon = "✓", color = "green" },
			},

			-- TMUX specific grouping
			{
				"<leader>tm",
				group = "Tmux",
				desc = "Tmux operations",
				icon = { icon = "󰓩", color = "blue" },
			},
			{
				"<leader>ta",
				group = "Tabs",
				desc = "Tab management",
				icon = { icon = "󰐱", color = "cyan" },
			},

			-- Path project navigation
			{
				"<leader>co",
				group = "Change Dir",
				desc = "Change to project directories",
				icon = { icon = "📂", color = "yellow" },
			},

			-- Code navigation and operations
			{
				"<leader>cd",
				desc = "Go to definition",
				icon = { icon = "󱀀", color = "blue" },
			},
			{
				"<leader>cr",
				desc = "Go to references",
				icon = { icon = "󰀮", color = "blue" },
			},

			-- Data conversion
			{
				"<leader>oy",
				desc = "YAML to JSON",
				icon = { icon = "󰌹", color = "green" },
			},
			{
				"<leader>oj",
				desc = "JSON to YAML",
				icon = { icon = "󰘦", color = "blue" },
			},

			-- Encoding/decoding
			{
				"<leader>oe",
				desc = "Base64 encode",
				icon = { icon = "󰯃", color = "purple" },
			},
			{
				"<leader>ob",
				desc = "Base64 decode",
				icon = { icon = "󰯄", color = "purple" },
			},
			{
				"<leader>oue",
				desc = "URL encode",
				icon = { icon = "🔄", color = "blue" },
			},
			{
				"<leader>oud",
				desc = "URL decode",
				icon = { icon = "🔄", color = "green" },
			},

			-- Git operations
			{
				"<leader>gp",
				group = "Push/Pull",
				desc = "Git push and pull operations",
				icon = { icon = "󰊢", color = "green" },
			},
		})

		-- Add a special mapping to show buffer-local keymaps
		wk.add({
			{
				"<leader>?",
				function()
					wk.show({ global = false })
				end,
				desc = "Buffer Local Keymaps",
				icon = { icon = "󰋖", color = "blue" },
			},
		})
	end,
}
