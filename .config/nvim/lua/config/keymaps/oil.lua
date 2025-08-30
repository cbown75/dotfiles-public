local km = vim.keymap

-- Oil.nvim keymaps
km.set("n", "<leader>eo", "<cmd>Oil<CR>", { desc = "Oil: Current directory" })
km.set("n", "<leader>ef", function()
	require("oil").open_float()
end, { desc = "Oil: Floating window" })

km.set("n", "<leader>ep", function()
	require("oil").open(vim.fn.getcwd())
end, { desc = "Oil: Project root" })

km.set("n", "<leader>eh", function()
	require("oil").open(vim.fn.expand("~"))
end, { desc = "Oil: Home directory" })

km.set("n", "<leader>ec", function()
	require("oil").open(vim.fn.stdpath("config"))
end, { desc = "Oil: Nvim config" })

-- Quick access - these don't conflict with your existing mappings
km.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil: Parent directory" })

-- Neo-tree keymaps (keeping your existing ones)
km.set("n", "<leader>en", ":Neotree filesystem reveal left<CR>", { desc = "Neo-tree: File explorer" })
km.set("n", "<leader>eb", ":Neotree buffers reveal float<CR>", { desc = "Neo-tree: Buffers" })
km.set("n", "<leader>eg", ":Neotree git_status reveal float<CR>", { desc = "Neo-tree: Git status" })

-- Toggle between Oil and Neo-tree
km.set("n", "<leader>et", function()
	local oil_buffers = vim.tbl_filter(function(buf)
		return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "oil"
	end, vim.api.nvim_list_bufs())

	local neotree_open = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "neo-tree" then
			neotree_open = true
			break
		end
	end

	if #oil_buffers > 0 then
		-- Close oil and open neo-tree
		for _, buf in ipairs(oil_buffers) do
			local windows = vim.fn.win_findbuf(buf)
			for _, win in ipairs(windows) do
				vim.api.nvim_win_close(win, false)
			end
		end
		vim.cmd("Neotree filesystem reveal left")
	elseif neotree_open then
		-- Close neo-tree and open oil
		vim.cmd("Neotree close")
		require("oil").open()
	else
		-- Nothing open, default to oil
		require("oil").open()
	end
end, { desc = "Toggle Oil/Neo-tree" })

-- DevOps shortcuts that work with your existing <leader>o structure
-- These extend your existing DevOps workflow
km.set("n", "<leader>oE", function()
	-- Capital E to avoid conflict with existing <leader>oe (encoding)
	local devops_dirs = {
		"./terraform",
		"./tf",
		"./infra",
		"./infrastructure",
		"./k8s",
		"./kubernetes",
		"./helm",
		"./charts",
		"./docker",
		"./ansible",
		"./playbooks",
	}

	local found_dirs = {}
	for _, dir in ipairs(devops_dirs) do
		if vim.fn.isdirectory(dir) == 1 then
			table.insert(found_dirs, dir)
		end
	end

	if #found_dirs == 0 then
		vim.notify("No DevOps directories found", vim.log.levels.WARN)
		return
	end

	if #found_dirs == 1 then
		require("oil").open(found_dirs[1])
	else
		vim.ui.select(found_dirs, {
			prompt = "Select DevOps directory:",
		}, function(choice)
			if choice then
				require("oil").open(choice)
			end
		end)
	end
end, { desc = "Oil: Browse DevOps directories" })

-- File creation in Oil
km.set("n", "<leader>ew", function()
	local oil = require("oil")
	if vim.bo.filetype == "oil" then
		local dir = oil.get_current_dir()
		if dir then
			vim.ui.input({
				prompt = "New file name: ",
			}, function(filename)
				if filename and filename ~= "" then
					local filepath = dir .. filename
					vim.cmd("edit " .. filepath)
				end
			end)
		end
	else
		vim.notify("Open Oil first to create files", vim.log.levels.WARN)
	end
end, { desc = "Oil: Create new file" })

km.set("n", "<leader>eW", function()
	local oil = require("oil")
	if vim.bo.filetype == "oil" then
		local dir = oil.get_current_dir()
		if dir then
			vim.ui.input({
				prompt = "New directory name: ",
			}, function(dirname)
				if dirname and dirname ~= "" then
					local dirpath = dir .. dirname
					vim.fn.mkdir(dirpath, "p")
					oil.open(dir) -- Refresh oil view
				end
			end)
		end
	else
		vim.notify("Open Oil first to create directories", vim.log.levels.WARN)
	end
end, { desc = "Oil: Create new directory" })

return {}
