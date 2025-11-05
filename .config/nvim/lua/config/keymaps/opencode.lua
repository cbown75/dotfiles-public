local km = vim.keymap

km.set("n", "<leader>oa", function()
  require("opencode").ask()
end, { desc = "Ask opencode with context" })

km.set("n", "<leader>ox", function()
  require("opencode").actions()
end, { desc = "Execute opencode actions" })

km.set("n", "<leader>oo", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode terminal" })

km.set("n", "<leader>or", function()
  require("opencode").reload_buffers()
end, { desc = "Reload opencode-modified buffers" })

km.set("n", "<leader>oe", function()
  require("opencode").explain()
end, { desc = "Explain current code" })

km.set("n", "<leader>oO", function()
  require("opencode").optimize()
end, { desc = "Optimize current code" })

km.set("n", "<leader>od", function()
  require("opencode").document()
end, { desc = "Document current code" })

km.set("n", "<leader>oT", function()
  require("opencode").test()
end, { desc = "Generate tests" })

km.set("n", "<leader>oR", function()
  require("opencode").review()
end, { desc = "Review current code" })

km.set("n", "<leader>of", function()
  require("opencode").fix()
end, { desc = "Fix issues in current code" })

km.set("v", "ga", function()
  require("opencode").add_selection()
end, { desc = "Add selection to opencode" })
