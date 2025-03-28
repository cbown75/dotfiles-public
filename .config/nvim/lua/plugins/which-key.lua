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
		},
		-- Layout configuration
		layout = {
			width = { min = 20 }, -- min width of the columns
			spacing = 3, -- spacing between columns
		},
		-- Key behavior
		keys = {
			scroll_down = "<c-d>", -- scroll down in the popup
			scroll_up = "<c-u>", -- scroll up in the popup
		},
		-- Plugins configuration
		plugins = {
			marks = true, -- shows marks on ' and `
			registers = true, -- shows registers on " in NORMAL or <C-r> in INSERT
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z=
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		show_help = true, -- show help message in the command line
		show_keys = true, -- show the currently pressed key and its label
		triggers = {
			-- Automatically setup triggers
			{ "<auto>", mode = "nxso" },
		},
		disable = {
			ft = {},
			bt = {},
		},
		-- Icons for specific types of operations
		icons = {
			breadcrumb = "»", -- symbol used in the command line area
			separator = "➜", -- symbol used between a key and its label
			group = "+", -- symbol prepended to a group
			mappings = true, -- enable icons for mappings
			rules = {
				-- File operations
				{ pattern = "find_files", icon = { icon = "󰈞", color = "blue" } },
				{ pattern = "grep", icon = { icon = "󰊄", color = "yellow" } },
				{ pattern = "save", icon = { icon = "󰆓", color = "green" } },

				-- Buffer operations
				{ pattern = "buffer", icon = { icon = "󰓩", color = "purple" } },

				-- Git operations
				{ pattern = "git", icon = { icon = "󰊢", color = "red" } },
				{ pattern = "blame", icon = { icon = "󰜱", color = "orange" } },

				-- LSP operations
				{ pattern = "lsp", icon = { icon = "󰒕", color = "blue" } },
				{ pattern = "diagnostic", icon = { icon = "󰀨", color = "red" } },

				-- AI operations
				{ pattern = "avante", icon = { icon = "󱠁", color = "purple" } },

				-- Toggle operations
				{ pattern = "toggle", icon = { icon = "󰔡", color = "cyan" } },

				-- DevOps icons
				{ pattern = "<leader>k", icon = { icon = "󰠰", color = "blue" } }, -- Kubernetes
				{ pattern = "terraform", icon = { icon = "󱁢", color = "purple" } }, -- Terraform
				{ pattern = "<leader>ac", icon = { icon = "󰸏", color = "orange" } }, -- AWS
				{ pattern = "<leader>dc", icon = { icon = "󰡨", color = "blue" } }, -- Docker
				--{ pattern = "<leader>py", icon = { icon = "󰌠", color = "yellow" } }, -- Python
				{ pattern = "<leader>ur", icon = { icon = "🔄", color = "blue" } }, -- URL operations
				{ pattern = "<leader>yj", icon = { icon = "󰌹", color = "green" } }, -- YAML
				{ pattern = "<leader>jy", icon = { icon = "󰘦", color = "blue" } }, -- JSON
				{ pattern = "<leader>be", icon = { icon = "󰯃", color = "purple" } }, -- Base64

				-- Resource-specific icons
				{ pattern = ".*pod.*", icon = { icon = "󰠳", color = "green" } },
				{ pattern = ".*deploy.*", icon = { icon = "󰄢", color = "blue" } },
				{ pattern = ".*service.*", icon = { icon = "󱏞", color = "purple" } },
				{ pattern = ".*ec2.*", icon = { icon = "󰯉", color = "orange" } },
				{ pattern = ".*s3.*", icon = { icon = "󰧺", color = "yellow" } },
				{ pattern = ".*lambda.*", icon = { icon = "λ", color = "cyan" } },
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Add keymappings using the new add method
		wk.add({
			-- Main groups with descriptions and icons
			{
				"<leader>a",
				group = "󱠁 AI Assistant",
				desc = "AI assistance with Claude",
				icon = { icon = "󱠁", color = "purple" },
			},
			{
				"<leader>b",
				group = "󰓩 Buffer",
				desc = "Buffer management",
				icon = { icon = "󰓩", color = "blue" },
			},
			{
				"<leader>c",
				group = "󰅱 Code",
				desc = "Code actions and editing",
				icon = { icon = "󰅱", color = "green" },
			},
			{
				"<leader>d",
				group = "󰃤 Debug",
				desc = "Debugging operations",
				icon = { icon = "󰃤", color = "red" },
			},
			{
				"<leader>f",
				group = "󰈔 File/Find",
				desc = "File operations and search",
				icon = { icon = "󰈔", color = "yellow" },
			},
			{
				"<leader>g",
				group = "󰊢 Git/Go-to",
				desc = "Git operations and navigation",
				icon = { icon = "󰊢", color = "orange" },
			},
			{
				"<leader>k",
				group = "󰠰 Kubernetes",
				desc = "Kubernetes operations",
				icon = { icon = "󰠰", color = "blue" },
			},
			{
				"<leader>l",
				group = "󰒲 Lazy",
				desc = "Lazy plugin manager",
				icon = { icon = "󰒲", color = "blue" },
			},
			{
				"<leader>m",
				group = "󰍘 Misc",
				desc = "Miscellaneous tools",
				icon = { icon = "󰍘", color = "grey" },
			},
			{
				"<leader>s",
				group = "󱘧 Search",
				desc = "Search operations",
				icon = { icon = "󱘧", color = "yellow" },
			},
			{
				"<leader>t",
				group = "󰍉 Tab/Terminal",
				desc = "Tab & terminal management",
				icon = { icon = "󰍉", color = "cyan" },
			},
			{
				"<leader>u",
				group = "󰒓 UI Toggle",
				desc = "Toggle UI features",
				icon = { icon = "󰒓", color = "purple" },
			},
			{
				"<leader>ur",
				group = "🔄 URL Ops",
				desc = "URL encoding/decoding",
				icon = { icon = "🔄", color = "blue" },
			},
			{
				"<leader>v",
				group = "󰁨 Validate",
				desc = "Validation commands",
				icon = { icon = "󰁨", color = "green" },
			},
			{
				"<leader>w",
				group = "󱂬 Window",
				desc = "Window management",
				icon = { icon = "󱂬", color = "blue" },
			},
			{
				"<leader>x",
				group = "󰁨 Diagnostics/Utilities",
				desc = "Diagnostics & utilities",
				icon = { icon = "󰁨", color = "red" },
			},
			{
				"[",
				group = "⬆️ Previous",
				desc = "Navigate to previous items",
				icon = { icon = "⬆️", color = "blue" },
			},
			{ "]", group = "⬇️ Next", desc = "Navigate to next items", icon = { icon = "⬇️", color = "blue" } },
			{ "g", group = "🧭 Go to", desc = "Go to locations", icon = { icon = "🧭", color = "yellow" } },

			-- Core operations
			{ "<Esc>", desc = "Clear highlights", icon = { icon = "󰸱", color = "blue" } },
			{ "<leader><leader>", desc = "Find files", icon = { icon = "󰈞", color = "yellow" } },
			{ ",", desc = "Quick save", icon = { icon = "󰆓", color = "green" } },

			-- Basic operations
			{ "jj", desc = "Exit insert mode", mode = "i", icon = { icon = "󰸱", color = "red" } },
			{ "<Esc><Esc>", desc = "Exit terminal mode", mode = "t", icon = { icon = "󰸱", color = "red" } },

			-- Window navigation
			{ "<C-h>", desc = "Go to left pane", icon = { icon = "󰌕", color = "blue" } },
			{ "<C-j>", desc = "Go to lower pane", icon = { icon = "󰌐", color = "blue" } },
			{ "<C-k>", desc = "Go to upper pane", icon = { icon = "󰌖", color = "blue" } },
			{ "<C-l>", desc = "Go to right pane", icon = { icon = "󰌒", color = "blue" } },

			-- Better navigation
			{ "<C-d>", desc = "Half page down and center", icon = { icon = "⬇️", color = "blue" } },
			{ "<C-u>", desc = "Half page up and center", icon = { icon = "⬆️", color = "blue" } },
			{ "n", desc = "Next search result and center", icon = { icon = "⬇️", color = "cyan" } },
			{ "N", desc = "Previous search result and center", icon = { icon = "⬆️", color = "cyan" } },

			-- Clipboard operations - grouped by frequency of use
			{
				"<leader>y",
				desc = "Yank to system clipboard",
				mode = { "n", "v" },
				icon = { icon = "󰆏", color = "green" },
			},
			{ "<leader>p", desc = "Paste from system clipboard (after)", icon = { icon = "󰆐", color = "green" } },
			{ "<leader>P", desc = "Paste from system clipboard (before)", icon = { icon = "󰆐", color = "green" } },
			{
				"<leader>Y",
				desc = "Yank line to system clipboard",
				mode = { "n", "v" },
				icon = { icon = "󰆏", color = "green" },
			},
			{
				"<leader>d",
				desc = "Delete to system clipboard",
				mode = { "n", "v" },
				icon = { icon = "󰆴", color = "red" },
			},
			{
				"<leader>D",
				desc = "Delete line to system clipboard",
				mode = { "n", "v" },
				icon = { icon = "󰆴", color = "red" },
			},
		})

		-- File operations submenu with description
		wk.add({
			{
				"<leader>f",
				group = "File Operations",
				desc = "Operations for finding and managing files",
				icon = { icon = "󰈔", color = "yellow" },
			},
			{ "<leader>ff", desc = "Find files", icon = { icon = "󰈞", color = "blue" } },
			{ "<leader>fg", desc = "Find text", icon = { icon = "󰊄", color = "yellow" } },
			{ "<leader>fc", desc = "Find in code (no tests)", icon = { icon = "󰎔", color = "cyan" } },
			{ "<leader>fr", desc = "Recent files", icon = { icon = "󰋚", color = "purple" } },
			{ "<leader>fs", desc = "Save file", icon = { icon = "󰆓", color = "green" } },
			{ "<leader>fw", desc = "Save all files", icon = { icon = "󰆓", color = "green" } },
			{ "<leader>fk", desc = "Find keymaps", icon = { icon = "󰌌", color = "orange" } },
			{ "<leader>/", desc = "Fuzzily search in current buffer", icon = { icon = "󰍉", color = "yellow" } },
			{ "<leader>fb", desc = "Find open buffers", icon = { icon = "󰓩", color = "blue" } },
		})

		-- Buffer operations submenu with description
		wk.add({
			{
				"<leader>b",
				group = "Buffer Operations",
				desc = "Operations for managing buffers",
				icon = { icon = "󰓩", color = "blue" },
			},
			{ "<leader>bf", desc = "Buffer list", icon = { icon = "󰈚", color = "blue" } },
			{ "<leader>bn", desc = "Next buffer", icon = { icon = "󰮰", color = "green" } },
			{ "<leader>bp", desc = "Previous buffer", icon = { icon = "󰮲", color = "green" } },
			{ "<leader>bd", desc = "Delete buffer", icon = { icon = "󰆴", color = "red" } },
		})

		-- Tab management submenu with description
		wk.add({
			{
				"<leader>t",
				group = "Tab/Terminal Operations",
				desc = "Operations for tabs and terminal",
				icon = { icon = "󰍉", color = "cyan" },
			},
			{ "<leader>to", desc = "Open new tab", icon = { icon = "󰐱", color = "green" } },
			{ "<leader>tx", desc = "Close current tab", icon = { icon = "󰅖", color = "red" } },
			{ "<leader>tn", desc = "Go to next tab", icon = { icon = "󰮰", color = "blue" } },
			{ "<leader>tp", desc = "Go to previous tab", icon = { icon = "󰮲", color = "blue" } },
			{ "<leader>tf", desc = "Open current buffer in new tab", icon = { icon = "󰐱", color = "cyan" } },
			{ "<leader>tt", desc = "Toggle terminal", icon = { icon = "󰆍", color = "purple" } },
			{ "<leader>tu", desc = "Undo history", icon = { icon = "󰕌", color = "orange" } },
		})

		-- Terraform operations - Added under Tab menu with tf prefix
		wk.add({
			{ "<leader>tf", desc = "Terraform Format", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>tp", desc = "Terraform Plan", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>ta", desc = "Terraform Apply", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>td", desc = "Terraform Destroy", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>ti", desc = "Terraform Init", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>tv", desc = "Terraform Validate", icon = { icon = "󱁢", color = "purple" } },
		})

		-- Window operations - use hydra-like functionality
		wk.add({
			{
				"<leader>w",
				group = "Window Operations",
				desc = "Operations for managing windows (press again for more)",
				icon = { icon = "󱂬", color = "blue" },
			},
		})

		-- Window operations hydra
		-- This will keep the menu open after the first w press
		local function window_hydra()
			-- Show the hydra mode (loop=true keeps it open until Esc is pressed)
			require("which-key").show({
				keys = "<c-w>",
				mode = "n",
				auto = false,
				loop = true, -- this is the key part that keeps the popup open
			})
		end

		wk.add({
			{ "<leader>wv", desc = "Split vertically", icon = { icon = "󰤼", color = "blue" } },
			{ "<leader>ws", desc = "Split horizontally", icon = { icon = "󰤻", color = "blue" } },
			{ "<leader>w=", desc = "Equal window width", icon = { icon = "󰯑", color = "blue" } },
			{ "<leader>w+", desc = "Increase window height", icon = { icon = "󰁝", color = "green" } },
			{ "<leader>w-", desc = "Decrease window height", icon = { icon = "󰁅", color = "red" } },
			{ "<leader>w>", desc = "Increase window width", icon = { icon = "󰁔", color = "green" } },
			{ "<leader>w<", desc = "Decrease window width", icon = { icon = "󰁍", color = "red" } },
			{ "<leader>ww", window_hydra, desc = "Window hydra mode", icon = { icon = "󱂬", color = "cyan" } },
		})

		-- Code operations submenu with description
		wk.add({
			{
				"<leader>c",
				group = "Code Operations",
				desc = "Operations for code editing and navigation",
				icon = { icon = "󰅱", color = "green" },
			},
			{ "<leader>ca", desc = "Code actions", icon = { icon = "󰛩", color = "yellow" } },
			{ "<leader>cf", desc = "Format code", icon = { icon = "󰁨", color = "blue" } },
			{ "<leader>cr", desc = "Rename symbol", icon = { icon = "󰑕", color = "orange" } },
			{ "<leader>ci", desc = "Code info/hover", icon = { icon = "󰋽", color = "blue" } },
			{ "K", desc = "Show hover information", icon = { icon = "󰋽", color = "blue" } },
			{ "<leader>cR", desc = "Rename file", icon = { icon = "󰉍", color = "orange" } },
		})

		-- Project navigation - uses existing Change Dir group
		wk.add({
			{ "<leader>ct", desc = "Terraform Directory", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>ck", desc = "Kubernetes Directory", icon = { icon = "󰠰", color = "blue" } },
		})

		-- Go-to operations submenu with description
		wk.add({
			{
				"<leader>g",
				group = "Go-to Operations",
				desc = "Operations for navigation and Git",
				icon = { icon = "🧭", color = "yellow" },
			},
			{ "<leader>gd", desc = "Go to definition", icon = { icon = "󱀀", color = "blue" } },
			{ "<leader>gr", desc = "Go to references", icon = { icon = "󰀮", color = "blue" } },
		})

		-- Diagnostics submenu with description
		wk.add({
			{
				"<leader>x",
				group = "Diagnostics/Utilities",
				desc = "Diagnostic tools and utilities",
				icon = { icon = "󰁨", color = "red" },
			},
			{ "[d", desc = "Previous diagnostic", icon = { icon = "⬆️", color = "red" } },
			{ "]d", desc = "Next diagnostic", icon = { icon = "⬇️", color = "red" } },
			{ "<leader>e", desc = "Show diagnostic message", icon = { icon = "󰀨", color = "red" } },
			{ "<leader>q", desc = "Open diagnostic list", icon = { icon = "󰀪", color = "orange" } },
		})

		-- Search operations submenu with description
		wk.add({
			{
				"<leader>s",
				group = "Search Operations",
				desc = "Operations for searching content",
				icon = { icon = "󱘧", color = "yellow" },
			},
			{ "<leader>sr", desc = "Search and replace", icon = { icon = "󰒕", color = "orange" } },
			{ "<leader>ss", desc = "Search symbols", icon = { icon = "󰯻", color = "blue" } },
			{ "<leader>st", desc = "Search TODOs", icon = { icon = "󰄬", color = "yellow" } },
			{ "<leader>sT", desc = "Search TODO/FIX/FIXME", icon = { icon = "󰄬", color = "red" } },
			{ "<leader>sw", desc = "Search word under cursor", icon = { icon = "󰝔", color = "blue" } },
			{ "<leader>sn", desc = "Search notifications", icon = { icon = "󰂜", color = "purple" } },
		})

		-- Trouble diagnostics submenu with description
		wk.add({
			{
				"<leader>x",
				group = "Trouble/Diagnostics",
				desc = "Trouble and diagnostic operations",
				icon = { icon = "󰁨", color = "red" },
			},
			{ "<leader>xx", desc = "Toggle Trouble", icon = { icon = "󰔫", color = "red" } },
			{ "<leader>xw", desc = "Workspace diagnostics", icon = { icon = "󱁉", color = "orange" } },
			{ "<leader>xd", desc = "Document diagnostics", icon = { icon = "󰦪", color = "orange" } },
			{ "<leader>xq", desc = "Quickfix list", icon = { icon = "󰁨", color = "yellow" } },
			{ "<leader>xl", desc = "Location list", icon = { icon = "󰀫", color = "yellow" } },
			{ "gR", desc = "LSP references", icon = { icon = "󰀮", color = "blue" } },
			{ "<leader>xt", desc = "Todo (Trouble)", icon = { icon = "󰄬", color = "yellow" } },
			{ "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)", icon = { icon = "󰄬", color = "red" } },
			{ "<leader>xu", desc = "Undo Tree", icon = { icon = "󰕌", color = "green" } },
			{ "<leader>xb", desc = "Nav Buddy", icon = { icon = "🧭", color = "blue" } },
		})

		-- Git operations submenu with description
		wk.add({
			{
				"<leader>g",
				group = "Git Operations",
				desc = "Operations for Git integration",
				icon = { icon = "󰊢", color = "orange" },
			},
			{ "<leader>gb", desc = "Git blame line", icon = { icon = "󰜱", color = "blue" } },
			{ "<leader>gB", desc = "Git browse", mode = { "n", "v" }, icon = { icon = "󰖟", color = "blue" } },
			{ "<leader>gh", desc = "Git file history", icon = { icon = "󰔨", color = "yellow" } },
			{ "<leader>gg", desc = "Lazygit", icon = { icon = "󰊢", color = "green" } },
			{ "<leader>gl", desc = "Git log", icon = { icon = "󰔨", color = "blue" } },
			{ "<leader>gc", desc = "Git commits", icon = { icon = "󰜘", color = "purple" } },
			{ "<leader>gf", desc = "Git buffer commits", icon = { icon = "󰜘", color = "cyan" } },
			{ "<leader>gi", desc = "Advanced Git search", icon = { icon = "󱘧", color = "yellow" } },
		})

		-- Git extended operations
		wk.add({
			{
				"<leader>gp",
				group = "Git Push/Pull",
				desc = "Git push and pull operations",
				icon = { icon = "󰊢", color = "green" },
			},
			{ "<leader>gpp", desc = "Pull", icon = { icon = "󰁍", color = "blue" } },
			{ "<leader>gps", desc = "Push", icon = { icon = "󰁔", color = "red" } },
		})

		-- Toggle/UI operations submenu with description
		wk.add({
			{
				"<leader>t",
				group = "Toggle Operations",
				desc = "Various toggle operations",
				icon = { icon = "󰍉", color = "cyan" },
			},
			{ "<leader>tt", desc = "Toggle terminal", icon = { icon = "󰆍", color = "green" } },
			{ "<c-/>", desc = "Toggle terminal", icon = { icon = "󰆍", color = "green" } },
			{ "<c-_>", desc = "which_key_ignore" },
			{ "<leader>z", desc = "Toggle Zen Mode", icon = { icon = "󰍕", color = "blue" } },
			{ "<leader>Z", desc = "Toggle Zoom", icon = { icon = "󰍉", color = "blue" } },
			{ "<leader>.", desc = "Toggle Scratch Buffer", icon = { icon = "󰓆", color = "yellow" } },
			{ "<leader>S", desc = "Select Scratch Buffer", icon = { icon = "󰤱", color = "yellow" } },
			{ "<leader>n", desc = "Notification History", icon = { icon = "󰂚", color = "purple" } },
			{ "<leader>N", desc = "Neovim News", icon = { icon = "󰋻", color = "blue" } },
		})

		-- UI toggles submenu with description
		wk.add({
			{
				"<leader>u",
				group = "UI Toggles",
				desc = "Toggle UI elements and features",
				icon = { icon = "󰒓", color = "purple" },
			},
			{ "<leader>us", desc = "Toggle spelling", icon = { icon = "󰓆", color = "green" } },
			{ "<leader>uw", desc = "Toggle word wrap", icon = { icon = "󰖶", color = "blue" } },
			{ "<leader>uL", desc = "Toggle relative numbers", icon = { icon = "󰔡", color = "yellow" } },
			{ "<leader>ud", desc = "Toggle diagnostics", icon = { icon = "󰁨", color = "red" } },
			{ "<leader>ul", desc = "Toggle line numbers", icon = { icon = "󰺀", color = "blue" } },
			{ "<leader>uc", desc = "Toggle conceal", icon = { icon = "󰘻", color = "green" } },
			{ "<leader>uT", desc = "Toggle treesitter", icon = { icon = "󱞧", color = "green" } },
			{ "<leader>ub", desc = "Toggle background", icon = { icon = "󰆁", color = "blue" } },
			{ "<leader>uh", desc = "Toggle inlay hints", icon = { icon = "󰋼", color = "blue" } },
			{ "<leader>ug", desc = "Toggle indent guides", icon = { icon = "⋮", color = "cyan" } },
			{ "<leader>uD", desc = "Toggle dim mode", icon = { icon = "󰃞", color = "yellow" } },
			{ "<leader>uC", desc = "Color picker", icon = { icon = "󰉦", color = "orange" } },
			{ "<leader>un", desc = "Dismiss Notifications", icon = { icon = "󰅖", color = "red" } },
		})

		-- Avante AI (Claude) Integration
		wk.add({
			{
				"<leader>a",
				group = "AI Assistant",
				desc = "Claude AI Assistant operations",
				icon = { icon = "󱠁", color = "purple" },
			},
			{ "<leader>aa", desc = "New Avante chat", icon = { icon = "󰭹", color = "green" } },
			{ "<leader>ac", desc = "Avante Clear", icon = { icon = "󰃢", color = "red" } },
			{ "<leader>af", desc = "Avante Focus", icon = { icon = "󰭶", color = "blue" } },
			{ "<leader>at", desc = "Toggle Avante", icon = { icon = "󰅂", color = "yellow" } },
			{ "<leader>am", desc = "Avante Models", icon = { icon = "󰻽", color = "blue" } },
		})

		-- Visual mode AI Assistant mappings
		wk.add({
			{
				"<leader>a",
				group = "AI Selection",
				desc = "AI operations on selection",
				mode = "v",
				icon = { icon = "󱠁", color = "purple" },
			},
			{ "<leader>as", desc = "Ask Avante about selection", mode = "v", icon = { icon = "󰞋", color = "blue" } },
			{
				"<leader>ai",
				desc = "Improve selection with Avante",
				mode = "v",
				icon = { icon = "󰃢", color = "green" },
			},
			{
				"<leader>ae",
				desc = "Explain selection with Avante",
				mode = "v",
				icon = { icon = "󱁻", color = "yellow" },
			},
		})

		-- Navigation aids
		wk.add({
			{ "<C-n>", desc = "File Explorer", icon = { icon = "󰥨", color = "blue" } },
		})

		-- Todo comment navigation
		wk.add({
			{ "]t", desc = "Next todo comment", icon = { icon = "󰄬", color = "yellow" } },
			{ "[t", desc = "Previous todo comment", icon = { icon = "󰄬", color = "yellow" } },
		})

		-- Treesitter textobjects
		wk.add({
			{
				"<leader>o",
				group = "Parameter Operations",
				desc = "Operations for function parameters",
				icon = { icon = "󰆧", color = "blue" },
			},
			{ "<leader>oi", desc = "Swap with next parameter", icon = { icon = "󰁔", color = "green" } },
			{ "<leader>os", desc = "Swap with previous parameter", icon = { icon = "󰁍", color = "green" } },
		})

		-- Miscellaneous utilities
		wk.add({
			{
				"<leader>m",
				group = "Miscellaneous",
				desc = "Miscellaneous utilities",
				icon = { icon = "󰍘", color = "grey" },
			},
			{ "<leader>mp", desc = "Format with conform", icon = { icon = "󰁨", color = "blue" } },
			{ "<leader>xd", desc = "Insert Date", icon = { icon = "󰃮", color = "blue" } },
			{ "<leader>lu", desc = "Lazy Update (Sync)", icon = { icon = "󰒲", color = "green" } },
		})

		-- Add a special mapping to show buffer-local keymaps
		wk.add({
			{
				"<leader>?",
				function()
					wk.show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
				icon = { icon = "󰋖", color = "blue" },
			},
		})

		wk.add({
			{
				"<leader>h",
				group = "Harpoon",
				desc = "Quick file navigation",
				icon = { icon = "󰛢", color = "orange" },
			},
			{ "<leader>ha", desc = "Add file", icon = { icon = "󰐕", color = "green" } },
			{ "<leader>he", desc = "Quick menu", icon = { icon = "󰋇", color = "blue" } },
			{ "<leader>hf", desc = "Find files", icon = { icon = "󰈞", color = "yellow" } },
			{ "<leader>h1", desc = "File 1", icon = { icon = "1️⃣", color = "purple" } },
			{ "<leader>h2", desc = "File 2", icon = { icon = "2️⃣", color = "purple" } },
			{ "<leader>h3", desc = "File 3", icon = { icon = "3️⃣", color = "purple" } },
			{ "<leader>h4", desc = "File 4", icon = { icon = "4️⃣", color = "purple" } },
		})

		wk.add({
			-- Snippet navigation keymaps
			{ "<C-k>", desc = "Snippet: Expand or jump forward", mode = { "i", "s" } },
			{ "<C-j>", desc = "Snippet: Jump backward", mode = { "i", "s" } },
			{ "<C-l>", desc = "Snippet: Cycle choices forward", mode = { "i", "s" } },
			{ "<C-h>", desc = "Snippet: Cycle choices backward", mode = { "i", "s" } },

			-- Snippet management
			{
				"<leader>s",
				group = "Snippets",
				desc = "Snippet management",
				icon = { icon = "✂️", color = "blue" },
			},
			{ "<leader>se", desc = "Edit snippets for current filetype", icon = { icon = "✏️", color = "green" } },
		})

		-- Flash.nvim keymaps
		wk.add({
			-- Basic flash motions
			{ "s", desc = "Flash jump", mode = { "n", "x", "o" }, icon = { icon = "⚡", color = "yellow" } },
			{ "S", desc = "Flash treesitter", mode = { "n", "x", "o" }, icon = { icon = "🌲", color = "green" } },
			{ "r", desc = "Remote flash", mode = "o", icon = { icon = "📡", color = "blue" } },
			{ "R", desc = "Treesitter search", mode = { "o", "x" }, icon = { icon = "🔍", color = "purple" } },
			{ "<c-s>", desc = "Toggle Flash Search", mode = "c", icon = { icon = "⚡", color = "yellow" } },

			-- Enhanced f/t motions
			{ "f", desc = "Flash find forward", mode = { "n", "x", "o" }, icon = { icon = "→", color = "blue" } },
			{ "F", desc = "Flash find backward", mode = { "n", "x", "o" }, icon = { icon = "←", color = "blue" } },
			{ "t", desc = "Flash till forward", mode = { "n", "x", "o" }, icon = { icon = "→", color = "blue" } },
			{ "T", desc = "Flash till backward", mode = { "n", "x", "o" }, icon = { icon = "←", color = "blue" } },

			-- Flash submenu (using <leader>j instead of <leader>f)
			{
				"<leader>j",
				group = "Jump (Flash)",
				desc = "Flash navigation actions",
				icon = { icon = "⚡", color = "yellow" },
			},
			{ "<leader>js", desc = "Flash line start", icon = { icon = "⏮️", color = "blue" } },
			{ "<leader>je", desc = "Flash line end", icon = { icon = "⏭️", color = "blue" } },
			{ "<leader>jw", desc = "Flash exact word", icon = { icon = "🔤", color = "green" } },
			{ "<leader>jf", desc = "Flash to function definitions", icon = { icon = "🧩", color = "purple" } },
			{ "<leader>jc", desc = "Flash to comments", icon = { icon = "💬", color = "green" } },
		})

		wk.add({
			{ "<leader>t", group = "Tmux", desc = "Tmux operations", icon = { icon = "󰓩", color = "blue" } },
			{ "<leader>ts", desc = "Create new tmux session", icon = { icon = "󰐱", color = "green" } },
			{ "<leader>ta", desc = "Attach to tmux session", icon = { icon = "󰉁", color = "green" } },
			{ "<leader>tl", desc = "List tmux sessions", icon = { icon = "󰋇", color = "blue" } },

			-- Pane management under window submenu
			{ "<leader>tw+", desc = "Resize pane up", icon = { icon = "󰁝", color = "yellow" } },
			{ "<leader>tw-", desc = "Resize pane down", icon = { icon = "󰁅", color = "yellow" } },
			{ "<leader>tw<", desc = "Resize pane left", icon = { icon = "󰁍", color = "yellow" } },
			{ "<leader>tw>", desc = "Resize pane right", icon = { icon = "󰁔", color = "yellow" } },

			-- Terminal integration
			{ "<leader>th", desc = "Horiz. terminal split", icon = { icon = "󰆍", color = "green" } },
			{ "<leader>tv", desc = "Vert. terminal split", icon = { icon = "󰆍", color = "green" } },
		})

		-- Kubernetes operations
		wk.add({
			{ "<leader>kc", desc = "Switch Context", icon = { icon = "󰠰", color = "blue" } },
			{ "<leader>kp", desc = "Get Pods", icon = { icon = "󰠳", color = "green" } },
			{ "<leader>kd", desc = "Get Deployments", icon = { icon = "󰄢", color = "blue" } },
			{ "<leader>ks", desc = "Get Services", icon = { icon = "󱏞", color = "purple" } },
			{ "<leader>kn", desc = "Get Nodes", icon = { icon = "󰒋", color = "orange" } },
			{ "<leader>kl", desc = "View Pod Logs", icon = { icon = "󰨗", color = "cyan" } },
		})

		-- AWS operations - Added with ac prefix for AWS Change profile
		wk.add({
			{ "<leader>ac", desc = "AWS Change Profile", icon = { icon = "󰸏", color = "orange" } },
			{ "<leader>ae", desc = "AWS EC2 Instances", icon = { icon = "󰯉", color = "orange" } },
			{ "<leader>as", desc = "AWS S3 Buckets", icon = { icon = "󰧺", color = "yellow" } },
			{ "<leader>al", desc = "AWS Lambda Functions", icon = { icon = "λ", color = "cyan" } },
			{ "<leader>ar", desc = "AWS RDS Instances", icon = { icon = "󰆼", color = "blue" } },
		})

		-- Docker operations - Added with dc prefix
		wk.add({
			{ "<leader>dc", desc = "Docker Compose Up", icon = { icon = "󰡨", color = "blue" } },
			{ "<leader>dd", desc = "Docker Compose Down", icon = { icon = "󰡨", color = "red" } },
			{ "<leader>dl", desc = "Docker List Containers", icon = { icon = "󱁤", color = "blue" } },
			{ "<leader>di", desc = "Docker List Images", icon = { icon = "󰆍", color = "cyan" } },
			{ "<leader>dp", desc = "Docker Pull", icon = { icon = "󰄭", color = "green" } },
			{ "<leader>db", desc = "Docker Build", icon = { icon = "󱁻", color = "yellow" } },
		})

		--		-- Python operations
		--		wk.add({
		--			{ "<leader>pyv", desc = "Select Venv", icon = { icon = "󰌠", color = "yellow" } },
		--		})

		-- YAML/JSON conversion
		wk.add({
			{ "<leader>yj", desc = "YAML to JSON", icon = { icon = "󰌹", color = "green" } },
			{ "<leader>jy", desc = "JSON to YAML", icon = { icon = "󰘦", color = "blue" } },
		})

		-- Base64 operations
		wk.add({
			{ "<leader>be", desc = "Base64 Encode", mode = "v", icon = { icon = "󰯃", color = "purple" } },
			{ "<leader>bd", desc = "Base64 Decode", mode = "v", icon = { icon = "󰯄", color = "purple" } },
		})

		-- URL operations
		wk.add({
			{ "<leader>ure", desc = "URL Encode", mode = "v", icon = { icon = "🔄", color = "blue" } },
			{ "<leader>urd", desc = "URL Decode", mode = "v", icon = { icon = "🔄", color = "green" } },
		})

		-- Validation operations
		wk.add({
			{ "<leader>vt", desc = "Validate Terraform", icon = { icon = "󱁢", color = "purple" } },
			{ "<leader>vk", desc = "Validate Kubernetes", icon = { icon = "󰠰", color = "blue" } },
			{ "<leader>vy", desc = "Validate YAML", icon = { icon = "󰌹", color = "green" } },
			{ "<leader>vd", desc = "Validate Dockerfile", icon = { icon = "󰡨", color = "blue" } },
		})

		-- SSH shortcuts
		wk.add({
			{ "<leader>sh", desc = "SSH to Host", icon = { icon = "󰌘", color = "green" } },
		})
	end,
}
