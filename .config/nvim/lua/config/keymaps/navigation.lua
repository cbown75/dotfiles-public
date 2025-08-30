local km = vim.keymap

-- Window operations
km.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split vertically" })
km.set("n", "<leader>ws", ":split<CR>", { desc = "Split horizontally" })
km.set("n", "<leader>w=", "<C-w>=", { desc = "Equal window width" })
km.set("n", "<leader>w+", ":resize +5<CR>", { desc = "Increase window height" })
km.set("n", "<leader>w-", ":resize -5<CR>", { desc = "Decrease window height" })
km.set("n", "<leader>w>", ":vertical resize +5<CR>", { desc = "Increase window width" })
km.set("n", "<leader>w<", ":vertical resize -5<CR>", { desc = "Decrease window width" })
km.set("n", "<leader>ww", function()
	if require("which-key") then
		require("which-key").show({
			keys = "<c-w>",
			mode = "n",
			auto = false,
			loop = true,
		})
	end
end, { desc = "Window hydra mode" })

-- REMOVED: Tab management (now in tmux.lua under <leader>ta prefix)

-- Zen mode and similar UI state
km.set("n", "<leader>z", function()
	if require("snacks") and require("snacks").zen then
		require("snacks").zen()
	end
end, { desc = "Toggle Zen Mode" })

km.set("n", "<leader>Z", function()
	if require("snacks") and require("snacks").zen then
		require("snacks").zen.zoom()
	end
end, { desc = "Toggle Zoom" })

-- Enhanced tmux navigation
km.set("n", "<C-h>", function()
	if require("tmux") then
		require("tmux").move_left()
	end
end, { desc = "Move to left pane" })

km.set("n", "<C-j>", function()
	if require("tmux") then
		require("tmux").move_down()
	end
end, { desc = "Move to lower pane" })

km.set("n", "<C-k>", function()
	if require("tmux") then
		require("tmux").move_up()
	end
end, { desc = "Move to upper pane" })

km.set("n", "<C-l>", function()
	if require("tmux") then
		require("tmux").move_right()
	end
end, { desc = "Move to right pane" })

-- Harpoon keymaps
km.set("n", "<leader>ha", function()
	if require("harpoon") and require("harpoon.mark") then
		require("harpoon.mark").add_file()
	end
end, { desc = "Harpoon add file" })

km.set("n", "<leader>he", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").toggle_quick_menu()
	end
end, { desc = "Harpoon quick menu" })

-- Navigation keymaps
km.set("n", "<leader>h1", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_file(1)
	end
end, { desc = "Harpoon file 1" })

km.set("n", "<leader>h2", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_file(2)
	end
end, { desc = "Harpoon file 2" })

km.set("n", "<leader>h3", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_file(3)
	end
end, { desc = "Harpoon file 3" })

km.set("n", "<leader>h4", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_file(4)
	end
end, { desc = "Harpoon file 4" })

-- Quick navigation with Alt+j/k
km.set("n", "<A-j>", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_next()
	end
end, { desc = "Harpoon next file" })

km.set("n", "<A-k>", function()
	if require("harpoon") and require("harpoon.ui") then
		require("harpoon.ui").nav_prev()
	end
end, { desc = "Harpoon previous file" })

-- Telescope integration for fuzzy finding through harpoon marks
km.set("n", "<leader>hf", function()
	if require("telescope") and require("telescope").extensions and require("telescope").extensions.harpoon then
		require("telescope").extensions.harpoon.marks()
	end
end, { desc = "Harpoon find files" })

-- Flash.nvim integration
km.set({ "n", "x", "o" }, "s", function()
	if require("flash") then
		require("flash").jump()
	end
end, { desc = "Flash jump" })

km.set({ "n", "x", "o" }, "S", function()
	if require("flash") then
		require("flash").treesitter()
	end
end, { desc = "Flash treesitter" })

km.set({ "n", "x", "o" }, "f", function()
	if require("flash") then
		require("flash").jump({
			search = { mode = "search", max_length = 1 },
			pattern = "^",
		})
	end
end, { desc = "Flash find forward" })

km.set({ "n", "x", "o" }, "F", function()
	if require("flash") then
		require("flash").jump({
			search = { mode = "search", max_length = 1, forward = false },
			pattern = "^",
		})
	end
end, { desc = "Flash find backward" })

return {}
