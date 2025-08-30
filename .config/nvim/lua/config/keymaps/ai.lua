local km = vim.keymap

-- Avante AI (Claude) Integration
km.set("n", "<leader>aa", "<cmd>AvanteChat<cr>", { desc = "New Avante chat" })
km.set("n", "<leader>ax", "<cmd>AvanteClear<cr>", { desc = "Avante Clear" })
km.set("n", "<leader>af", "<cmd>AvanteFocus<cr>", { desc = "Avante Focus" })
km.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
km.set("n", "<leader>am", "<cmd>AvanteModels<cr>", { desc = "Avante Models" })

-- Visual mode selection operations
km.set("v", "<leader>as", function()
	require("avante").selection()
end, { desc = "Ask Avante about selection" })

km.set("v", "<leader>ai", function()
	require("avante").improve_selection()
end, { desc = "Improve selection with Avante" })

km.set("v", "<leader>ae", function()
	require("avante").explain_selection()
end, { desc = "Explain selection with Avante" })

-- REMOVED: Conflicting Supermaven keymaps that interfered with nvim-cmp
-- The old <C-l> mapping for Supermaven accept_suggestion is removed because:
-- 1. Supermaven is now configured as a cmp source only
-- 2. This prevents Tab key conflicts
-- 3. All AI completions now go through nvim-cmp's unified interface

-- FIXED: Ghost text acceptance using a dedicated key that doesn't conflict
vim.keymap.set("i", "<C-g>", function()
	local cmp = require("cmp")

	if cmp.visible() then
		-- Menu is visible, confirm selection
		cmp.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	else
		-- For ghost text, trigger completion first, then confirm
		cmp.complete()
		vim.schedule(function()
			if cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				})
			end
		end)
	end
end, { desc = "Accept completion/ghost text", silent = true })

-- Alternative: Use Right Arrow for ghost text (common pattern)
vim.keymap.set("i", "<C-Right>", function()
	local cmp = require("cmp")

	if cmp.visible() then
		cmp.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	else
		cmp.complete()
		vim.schedule(function()
			if cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				})
			else
				-- Fallback to normal Right arrow
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
			end
		end)
	end
end, { desc = "Accept completion or move cursor", silent = true })

-- Debug helper for troubleshooting completion issues
vim.keymap.set("i", "<C-x><C-g>", function()
	local cmp = require("cmp")
	print("=== nvim-cmp Debug Info ===")
	print("CMP visible:", cmp.visible())
	print("Active entry:", cmp.get_active_entry() and "yes" or "no")
	print("Ghost text enabled:", vim.inspect(cmp.get_config().experimental.ghost_text))
	print("vim.g.ai_cmp:", vim.g.ai_cmp)

	-- Show available sources
	local sources = {}
	for _, source in ipairs(cmp.get_config().sources or {}) do
		if source[1] then
			for _, s in ipairs(source) do
				table.insert(sources, s.name)
			end
		else
			table.insert(sources, source.name)
		end
	end
	print("Active sources:", table.concat(sources, ", "))

	-- Try to trigger completion
	if not cmp.visible() then
		print("Triggering completion...")
		cmp.complete()
	end
end, { desc = "Debug completion state", silent = false })

return {}
