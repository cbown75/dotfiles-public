local km = vim.keymap

-- AI Operations group
km.set("n", "<leader>a", "<nop>", { desc = "AI Assistant" })

-- Avante AI (Claude) Integration
km.set("n", "<leader>aa", "<cmd>AvanteChat<cr>", { desc = "New Avante chat" })
km.set("n", "<leader>ax", "<cmd>AvanteClear<cr>", { desc = "Avante Clear" }) -- Changed from ac to ax to avoid conflict
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

vim.keymap.set("i", "<C-l>", function()
  local has_supermaven, sm = pcall(require, "supermaven-nvim.api")
  if has_supermaven and sm.accept_suggestion then
    sm.accept_suggestion()
  else
    vim.notify("Supermaven: accept_suggestion not found", vim.log.levels.ERROR)
  end
end, { desc = "Supermaven: Accept Suggestion", silent = true })

vim.keymap.set("i", "<C-]>", function()
  vim.fn["supermaven#ClearCompletion"]()
end, { desc = "Supermaven: Clear Suggestion", silent = true })
return {}
