local km = vim.keymap

-- Git operations
km.set("n", "<leader>gb", function()
  if require("snacks") and require("snacks").git then
    require("snacks").git.blame_line()
  end
end, { desc = "Git blame line" })

km.set({ "n", "v" }, "<leader>gB", function()
  if require("snacks") and require("snacks").gitbrowse then
    require("snacks").gitbrowse()
  end
end, { desc = "Git browse" })

km.set("n", "<leader>gh", function()
  if require("snacks") and require("snacks").lazygit then
    require("snacks").lazygit.log_file()
  end
end, { desc = "Git file history" })

km.set("n", "<leader>gg", function()
  if require("snacks") and require("snacks").lazygit then
    require("snacks").lazygit()
  end
end, { desc = "Lazygit" })

km.set("n", "<leader>gl", function()
  if require("snacks") and require("snacks").lazygit then
    require("snacks").lazygit.log()
  end
end, { desc = "Git log" })

km.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
km.set("n", "<leader>gf", "<cmd>Telescope git_bcommits<CR>", { desc = "Git buffer commits" })
km.set("n", "<leader>gi", "<cmd>AdvancedGitSearch<CR>", { desc = "Advanced Git search" })

return {}
