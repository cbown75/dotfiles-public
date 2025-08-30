local km = vim.keymap

-- Code operations
km.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
km.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
km.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
km.set("n", "<leader>ci", vim.lsp.buf.hover, { desc = "Code info/hover" })
km.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })

-- File operations within Code section
km.set("n", "<leader>cn", function()
	if require("snacks") and require("snacks").rename then
		require("snacks").rename.rename_file()
	end
end, { desc = "Rename file" }) -- Changed from cR to cn

-- Go-to operations - keep under lsp as they're related
km.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" }) -- Changed from gd to cd
km.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "Go to references" }) -- Keep the cr since we're in Code group

-- Diagnostics
km.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
km.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
km.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Show diagnostic message" }) -- Changed from e to ce
km.set("n", "<leader>cq", vim.diagnostic.setloclist, { desc = "Open diagnostic list" }) -- Changed from q to cq

-- Search operations - move to search group
km.set("n", "<leader>s", "<nop>", { desc = "Search Operations" })
km.set("n", "<leader>sr", function()
	if require("spectre") then
		require("spectre").open()
	end
end, { desc = "Search and replace" })
km.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search symbols" })
km.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })
km.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Search TODO/FIX/FIXME" })
km.set("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "Search word under cursor" })
km.set("n", "<leader>sn", "<cmd>Telescope notify<CR>", { desc = "Search notifications" })

-- Trouble diagnostics - move under separate section
km.set("n", "<leader>x", "<nop>", { desc = "Trouble/Diagnostics" })
km.set("n", "<leader>xx", function()
	if require("trouble") then
		require("trouble").toggle()
	end
end, { desc = "Toggle Trouble" })
km.set("n", "<leader>xw", function()
	if require("trouble") then
		require("trouble").toggle("workspace_diagnostics")
	end
end, { desc = "Workspace diagnostics" })
km.set("n", "<leader>xd", function()
	if require("trouble") then
		require("trouble").toggle("document_diagnostics")
	end
end, { desc = "Document diagnostics" })
km.set("n", "<leader>xq", function()
	if require("trouble") then
		require("trouble").toggle("quickfix")
	end
end, { desc = "Quickfix list" })
km.set("n", "<leader>xl", function()
	if require("trouble") then
		require("trouble").toggle("loclist")
	end
end, { desc = "Location list" })
km.set("n", "<leader>xr", function()
	if require("trouble") then
		require("trouble").toggle("lsp_references")
	end
end, { desc = "LSP references" }) -- Changed from gR to xr
km.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
km.set("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })
km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })

return {}
