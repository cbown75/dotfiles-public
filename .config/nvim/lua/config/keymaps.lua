local km = vim.keymap

-- Clear existing keymaps in specific modes
-- Use this carefully as it removes ALL keymaps in the specified mode
-- vim.api.nvim_set_keymap('n', '', '', { noremap = true })

-- Core operations
km.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
km.set("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
km.set("n", ",", ":w<CR>", { desc = "Quick save" })

-- Exit insert mode alternative
km.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Exit terminal mode
km.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Enhanced tmux navigation
km.set("n", "<C-h>", function()
	require("tmux").move_left()
end, { desc = "Move to left pane" })
km.set("n", "<C-j>", function()
	require("tmux").move_down()
end, { desc = "Move to lower pane" })
km.set("n", "<C-k>", function()
	require("tmux").move_up()
end, { desc = "Move to upper pane" })
km.set("n", "<C-l>", function()
	require("tmux").move_right()
end, { desc = "Move to right pane" })

-- Session management
km.set("n", "<leader>tF", function()
	_G.tmux_utils.find_session()
end, { desc = "Find tmux session" })
km.set("n", "<leader>tN", function()
	_G.tmux_utils.new_session()
end, { desc = "New tmux session" })
km.set("n", "<leader>tL", function()
	_G.tmux_utils.list_sessions()
end, { desc = "List tmux sessions" })

-- Window operations
km.set("n", "<leader>tW+", function()
	_G.tmux_utils.resize_pane("up")
end, { desc = "Resize pane up" })
km.set("n", "<leader>tW-", function()
	_G.tmux_utils.resize_pane("down")
end, { desc = "Resize pane down" })
km.set("n", "<leader>tW<", function()
	_G.tmux_utils.resize_pane("left")
end, { desc = "Resize pane left" })
km.set("n", "<leader>tW>", function()
	_G.tmux_utils.resize_pane("right")
end, { desc = "Resize pane right" })

-- Tmux splits
km.set("n", "<leader>tH", function()
	_G.tmux_utils.new_split("vertical")
end, { desc = "Horizontal tmux split" })
km.set("n", "<leader>tV", function()
	_G.tmux_utils.new_split("horizontal")
end, { desc = "Vertical tmux split" })

-- Toggle session recording (if using vim-obsession)
km.set("n", "<leader>tM", function()
	if _G.toggle_session_recording then
		_G.toggle_session_recording()
	else
		vim.cmd("Obsession")
	end
end, { desc = "Toggle tmux session recording" })

-- Tmux window/session management
km.set("n", "<leader>ts", ":!tmux new-session -d -s<space>", { desc = "Create new tmux session" })
km.set("n", "<leader>ta", ":!tmux attach -t<space>", { desc = "Attach to tmux session" })
km.set("n", "<leader>tl", ":!tmux list-sessions<CR>", { desc = "List tmux sessions" })

-- Tmux terminal in a specific pane
km.set("n", "<leader>th", ":silent !tmux split-window -h<CR>", { desc = "Horiz. terminal split" })
km.set("n", "<leader>tv", ":silent !tmux split-window -v<CR>", { desc = "Vert. terminal split" })

-- Disable arrow keys to enforce hjkl usage
km.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
km.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
km.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
km.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Better navigation
km.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
km.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
km.set("n", "n", "nzzzv", { desc = "Next search result and center" })
km.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Clipboard operations
km.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
km.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
km.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
km.set({ "n", "v" }, "<leader>D", '"+D', { desc = "Delete line to system clipboard" })
km.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard (after)" })
km.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

-- File operations
km.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
km.set(
	"n",
	"<leader>fg",
	"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Find text" }
)
km.set(
	"n",
	"<leader>fc",
	'<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
	{ desc = "Find in code (no tests)" }
)
km.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
km.set("n", "<leader>fs", ":w<CR>", { desc = "Save file" })
km.set("n", "<leader>fw", ":wa<CR>", { desc = "Save all files" })
km.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
km.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
		layout_config = { width = 0.7 },
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Buffer operations
km.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "Buffer list" })
km.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
km.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
km.set("n", "<leader>bd", function()
	require("snacks").bufdelete()
end, { desc = "Delete buffer" })
km.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find open buffers" })

-- Tab management
km.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
km.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
km.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
km.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
km.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Window operations
km.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split vertically" })
km.set("n", "<leader>ws", ":split<CR>", { desc = "Split horizontally" })
km.set("n", "<leader>w=", "<C-w>=", { desc = "Equal window width" })
km.set("n", "<leader>w+", ":resize +5<CR>", { desc = "Increase window height" })
km.set("n", "<leader>w-", ":resize -5<CR>", { desc = "Decrease window height" })
km.set("n", "<leader>w>", ":vertical resize +5<CR>", { desc = "Increase window width" })
km.set("n", "<leader>w<", ":vertical resize -5<CR>", { desc = "Decrease window width" })
km.set("n", "<leader>ww", function()
	require("which-key").show({
		keys = "<c-w>",
		mode = "n",
		auto = false,
		loop = true,
	})
end, { desc = "Window hydra mode" })

-- Code operations
km.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
km.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
km.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
km.set("n", "<leader>ci", vim.lsp.buf.hover, { desc = "Code info/hover" })
km.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
km.set("n", "<leader>cR", function()
	require("snacks").rename.rename_file()
end, { desc = "Rename file" })

-- Go-to operations
km.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
km.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })

-- Diagnostics
km.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
km.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
km.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Search operations
km.set("n", "<leader>sr", function()
	require("spectre").open()
end, { desc = "Search and replace" })
km.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search symbols" })
km.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })
km.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Search TODO/FIX/FIXME" })
km.set("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "Search word under cursor" })
km.set("n", "<leader>sn", "<cmd>Telescope notify<CR>", { desc = "Search notifications" })

-- Trouble diagnostics
km.set("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "Toggle Trouble" })
km.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "Workspace diagnostics" })
km.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "Document diagnostics" })
km.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, { desc = "Quickfix list" })
km.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "Location list" })
km.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "LSP references" })
km.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
km.set("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })

-- Git operations
km.set("n", "<leader>gb", function()
	require("snacks").git.blame_line()
end, { desc = "Git blame line" })
km.set({ "n", "v" }, "<leader>gB", function()
	require("snacks").gitbrowse()
end, { desc = "Git browse" })
km.set("n", "<leader>gh", function()
	require("snacks").lazygit.log_file()
end, { desc = "Git file history" })
km.set("n", "<leader>gg", function()
	require("snacks").lazygit()
end, { desc = "Lazygit" })
km.set("n", "<leader>gl", function()
	require("snacks").lazygit.log()
end, { desc = "Git log" })
km.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
km.set("n", "<leader>gf", "<cmd>Telescope git_bcommits<CR>", { desc = "Git buffer commits" })
km.set("n", "<leader>gi", "<cmd>AdvancedGitSearch<CR>", { desc = "Advanced Git search" })

-- Toggle/UI operations
km.set("n", "<leader>tt", function()
	require("snacks").terminal()
end, { desc = "Toggle terminal" })
km.set("n", "<c-/>", function()
	require("snacks").terminal()
end, { desc = "Toggle terminal" })
km.set("n", "<c-_>", function()
	require("snacks").terminal()
end, { desc = "which_key_ignore" })
km.set("n", "<leader>tu", "<cmd>Telescope undo<CR>", { desc = "Undo history" })
km.set("n", "<leader>z", function()
	require("snacks").zen()
end, { desc = "Toggle Zen Mode" })
km.set("n", "<leader>Z", function()
	require("snacks").zen.zoom()
end, { desc = "Toggle Zoom" })
km.set("n", "<leader>.", function()
	require("snacks").scratch()
end, { desc = "Toggle Scratch Buffer" })
km.set("n", "<leader>S", function()
	require("snacks").scratch.select()
end, { desc = "Select Scratch Buffer" })
km.set("n", "<leader>n", function()
	require("snacks").notifier.show_history()
end, { desc = "Notification History" })
km.set("n", "<leader>N", function()
	require("snacks").win({
		file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		width = 0.6,
		height = 0.6,
		wo = {
			spell = false,
			wrap = false,
			signcolumn = "yes",
			statuscolumn = " ",
			conceallevel = 3,
		},
	})
end, { desc = "Neovim News" })

-- UI toggles using globally defined toggle functions from snacks.lua
km.set("n", "<leader>us", function()
	_G.toggle_spelling()
end, { desc = "Toggle spelling" })
km.set("n", "<leader>uw", function()
	_G.toggle_wrap()
end, { desc = "Toggle word wrap" })
km.set("n", "<leader>uL", function()
	_G.toggle_relative_number()
end, { desc = "Toggle relative numbers" })
km.set("n", "<leader>ud", function()
	_G.toggle_diagnostics()
end, { desc = "Toggle diagnostics" })
km.set("n", "<leader>ul", function()
	_G.toggle_line_number()
end, { desc = "Toggle line numbers" })
km.set("n", "<leader>uc", function()
	_G.toggle_conceal()
end, { desc = "Toggle conceal" })
km.set("n", "<leader>uT", function()
	_G.toggle_treesitter()
end, { desc = "Toggle treesitter" })
km.set("n", "<leader>ub", function()
	_G.toggle_background()
end, { desc = "Toggle background" })
km.set("n", "<leader>uh", function()
	_G.toggle_inlay_hints()
end, { desc = "Toggle inlay hints" })
km.set("n", "<leader>ug", function()
	_G.toggle_indent()
end, { desc = "Toggle indent guides" })
km.set("n", "<leader>uD", function()
	_G.toggle_dim()
end, { desc = "Toggle dim mode" })
km.set("n", "<leader>un", function()
	require("snacks").notifier.hide()
end, { desc = "Dismiss Notifications" })
km.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", { desc = "Color picker" })

-- Avante AI (Claude) Integration
km.set("n", "<leader>aa", "<cmd>AvanteChat<cr>", { desc = "New Avante chat" })
km.set("n", "<leader>ac", "<cmd>AvanteClear<cr>", { desc = "Avante Clear" })
km.set("n", "<leader>af", "<cmd>AvanteFocus<cr>", { desc = "Avante Focus" })
km.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
km.set("n", "<leader>am", "<cmd>AvanteModels<cr>", { desc = "Avante Models" })
km.set("v", "<leader>as", function()
	require("avante").selection()
end, { desc = "Ask Avante about selection" })
km.set("v", "<leader>ai", function()
	require("avante").improve_selection()
end, { desc = "Improve selection with Avante" })
km.set("v", "<leader>ae", function()
	require("avante").explain_selection()
end, { desc = "Explain selection with Avante" })

-- Navigation aids
km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })
km.set("n", "<leader>xb", function()
	require("nvim-navbuddy").open()
end, { desc = "Nav Buddy" })
km.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "File Explorer" })

-- Todo comment navigation
km.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
km.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Treesitter textobjects
-- These are set via the treesitter-textobjects plugin directly and don't need explicit keymaps

-- Miscellaneous utilities
km.set("n", "<leader>mp", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format with conform" })

-- Add date
km.set("n", "<leader>xd", function()
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
	vim.api.nvim_feedkeys("o", "n", true)
end, { desc = "Insert Date" })

-- Lazy update/sync
km.set("n", "<leader>lu", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })

-- Show buffer local keymaps in which-key
km.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Harpoon keymaps for v1
km.set("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
end, { desc = "Harpoon add file" })

km.set("n", "<leader>he", function()
	require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon quick menu" })

-- Navigation keymaps
km.set("n", "<leader>h1", function()
	require("harpoon.ui").nav_file(1)
end, { desc = "Harpoon file 1" })

km.set("n", "<leader>h2", function()
	require("harpoon.ui").nav_file(2)
end, { desc = "Harpoon file 2" })

km.set("n", "<leader>h3", function()
	require("harpoon.ui").nav_file(3)
end, { desc = "Harpoon file 3" })

km.set("n", "<leader>h4", function()
	require("harpoon.ui").nav_file(4)
end, { desc = "Harpoon file 4" })

-- Quick navigation with Alt+j/k
km.set("n", "<A-j>", function()
	require("harpoon.ui").nav_next()
end, { desc = "Harpoon next file" })

km.set("n", "<A-k>", function()
	require("harpoon.ui").nav_prev()
end, { desc = "Harpoon previous file" })

-- Telescope integration for fuzzy finding through harpoon marks
km.set("n", "<leader>hf", function()
	require("telescope").extensions.harpoon.marks()
end, { desc = "Harpoon find files" })

-- Snippet navigation keymaps
km.set({ "i", "s" }, "<C-k>", function()
	if not _G.luasnip_helpers then
		return
	end
	_G.luasnip_helpers.expand_or_jump()
end, { silent = true, desc = "Snippet: Expand or jump forward" })

km.set({ "i", "s" }, "<C-j>", function()
	if not _G.luasnip_helpers then
		return
	end
	_G.luasnip_helpers.jump_prev()
end, { silent = true, desc = "Snippet: Jump backward" })

km.set({ "i", "s" }, "<C-l>", function()
	if not _G.luasnip_helpers then
		return
	end
	_G.luasnip_helpers.change_choice(1)
end, { silent = true, desc = "Snippet: Cycle choices forward" })

km.set({ "i", "s" }, "<C-h>", function()
	if not _G.luasnip_helpers then
		return
	end
	_G.luasnip_helpers.change_choice(-1)
end, { silent = true, desc = "Snippet: Cycle choices backward" })

-- Add SnippetEdit command keymap
km.set("n", "<leader>se", ":SnippetEdit<CR>", { desc = "Edit snippets for current filetype" })

-- Basic flash motions
km.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash jump" })

km.set({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash treesitter" })

km.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote flash" })

km.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter search" })

-- Toggle flash in command mode (when searching with / or ?)
km.set("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- Flash to the start or end of lines (using <leader>j prefix instead of <leader>f)
km.set("n", "<leader>js", function()
	require("flash").jump({
		search = { mode = "search", max_length = 0 },
		label = { after = false, before = true, uppercase = false },
		pattern = "^",
	})
end, { desc = "Flash line start" })

km.set("n", "<leader>je", function()
	require("flash").jump({
		search = { mode = "search", max_length = 0 },
		label = { after = true, before = false, uppercase = false },
		pattern = "$",
	})
end, { desc = "Flash line end" })

-- Flash exact word search
km.set("n", "<leader>jw", function()
	require("flash").jump({
		pattern = ".", -- Match any character
		search = {
			mode = function(str)
				-- Match whole words only
				return { search = str, forward = true, wrap = true, mode = "exact" }
			end,
		},
		-- Special highlight for word matches
		highlight = {
			groups = {
				match = "FlashMatch",
				current = "FlashCurrent",
			},
		},
	})
end, { desc = "Flash exact word" })

-- Enhanced f/t motions with labels
km.set({ "n", "x", "o" }, "f", function()
	require("flash").jump({
		search = { mode = "search", max_length = 1 },
		pattern = "^",
	})
end, { desc = "Flash find forward" })

km.set({ "n", "x", "o" }, "F", function()
	require("flash").jump({
		search = { mode = "search", max_length = 1, forward = false },
		pattern = "^",
	})
end, { desc = "Flash find backward" })

km.set({ "n", "x", "o" }, "t", function()
	require("flash").jump({
		search = { mode = "search", max_length = 1 },
		pattern = "^.",
		offset = -1,
	})
end, { desc = "Flash till forward" })

km.set({ "n", "x", "o" }, "T", function()
	require("flash").jump({
		search = { mode = "search", max_length = 1, forward = false },
		pattern = "^.",
		offset = 1,
	})
end, { desc = "Flash till backward" })

-- Additional custom motions

-- Jump to function definitions
km.set("n", "<leader>jf", function()
	require("flash").jump({
		matcher = function(win)
			-- Create a pattern to match function definitions in different languages
			local function_patterns = {
				lua = "function%s+[%w_%.]+%s*%(", -- Lua: function name()
				go = "func%s+[%w_]+%s*%(",    -- Go: func Name(
				python = "def%s+[%w_]+%s*%(", -- Python: def name(
				rust = "fn%s+[%w_]+%s*%(",    -- Rust: fn name(
				terraform = "%w+%s*%{",       -- Terraform: resource_type {
			}

			-- Get the current filetype
			local filetype = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
			local pattern = function_patterns[filetype] or "function%s+[%w_%.]+%s*%("

			-- Use the appropriate pattern based on filetype
			return {
				pattern = pattern,
				highlight = { matches = true },
			}
		end,
	})
end, { desc = "Flash to function definitions" })

-- Jump to any comment
km.set("n", "<leader>jc", function()
	require("flash").jump({
		search = { mode = "search" },
		pattern = "^%s*[/#-]+-*%s+", -- Match comment patterns in most languages
		highlight = {
			groups = {
				match = "Comment",
				current = "FlashCurrent",
			},
		},
	})
end, { desc = "Flash to comments" })
