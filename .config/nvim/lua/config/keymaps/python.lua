local km = vim.keymap

-- Python virtual environment activation
km.set("n", "<leader>opv", function()
	-- Try to find virtual environments in common locations
	local venv_dirs = {
		vim.fn.getcwd() .. "/venv",
		vim.fn.getcwd() .. "/.venv",
		vim.fn.expand("~/.virtualenvs"),
	}

	local venvs = {}
	for _, dir in ipairs(venv_dirs) do
		if vim.fn.isdirectory(dir) == 1 then
			if vim.fn.isdirectory(dir .. "/bin") == 1 then
				-- This is a single venv
				table.insert(venvs, dir)
			else
				-- This might be a directory containing multiple venvs
				local handle = io.popen("ls -1 " .. dir)
				if handle then
					for venv in handle:lines() do
						if vim.fn.isdirectory(dir .. "/" .. venv .. "/bin") == 1 then
							table.insert(venvs, dir .. "/" .. venv)
						end
					end
					handle:close()
				end
			end
		end
	end

	vim.ui.select(venvs, {
		prompt = "Select Python Virtual Environment:",
	}, function(choice)
		if choice then
			vim.env.VIRTUAL_ENV = choice
			-- Update PATH to include the venv's bin directory
			local venv_bin = choice .. "/bin"
			vim.env.PATH = venv_bin .. ":" .. vim.env.PATH
			vim.notify("Activated virtual environment: " .. choice, vim.log.levels.INFO)
		end
	end)
end, { desc = "Activate Python virtual environment" })

-- Python testing and debugging
km.set("n", "<leader>opt", ":terminal python -m pytest<CR>", { desc = "Run pytest" })
km.set("n", "<leader>opr", ":terminal python %<CR>", { desc = "Run current file" })
km.set("n", "<leader>opi", ":terminal python -m pip install -r requirements.txt<CR>", { desc = "Install requirements" })
km.set("n", "<leader>opf", ":terminal python -m black .<CR>", { desc = "Format with black" })

return {}
