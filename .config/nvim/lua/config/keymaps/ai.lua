local km = vim.keymap

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

return {}
