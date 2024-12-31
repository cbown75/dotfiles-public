local km = vim.keymap

km.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

km.set("n", "<leader>lu", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })

km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })

--nav buddy
km.set({ "n" }, "<leader>xb", ":lua require('nvim-navbuddy').open()<cr>", { desc = "Nav Buddy" })

-- Diagnostic keymaps
km.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
km.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
km.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

km.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

km.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
km.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
km.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
km.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

km.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
km.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
km.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
km.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
km.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
km.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)
km.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
km.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})

-- Yank into system clipboard
km.set({ "n", "v" }, "<leader>y", '"+y') -- yank motion
km.set({ "n", "v" }, "<leader>Y", '"+Y') -- yank line

-- Delete into system clipboard
km.set({ "n", "v" }, "<leader>dd", '"+d') -- delete motion
km.set({ "n", "v" }, "<leader>DD", '"+D') -- delete line

-- Paste from system clipboard
km.set("n", "<leader>p", '"+p') -- paste after cursor
km.set("n", "<leader>P", '"+P') -- paste before cursor

km.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

km.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
km.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
km.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
km.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
km.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Exit insert mode without hitting Esc
km.set("i", "jj", "<Esc>", { desc = "Esc" })

-- Easy add date/time
function date()
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
	vim.api.nvim_feedkeys("o", "n", true)
end

km.set("n", "<Leader>xd", "<cmd>lua date()<cr>", { desc = "Insert Date" })
