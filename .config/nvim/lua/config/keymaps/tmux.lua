local km = vim.keymap

-- Terminal operations
km.set("n", "<leader>ts", ":terminal<CR>", { desc = "Open terminal (horizontal split)" })
km.set("n", "<leader>tv", ":vnew | terminal<CR>", { desc = "Open terminal (vertical split)" })

-- Tmux integration
km.set("n", "<leader>tmf", function()
  if _G.tmux_utils and _G.tmux_utils.find_session then
    _G.tmux_utils.find_session()
  end
end, { desc = "Find tmux session" })

km.set("n", "<leader>tmn", function()
  if _G.tmux_utils and _G.tmux_utils.new_session then
    _G.tmux_utils.new_session()
  end
end, { desc = "New tmux session" })

km.set("n", "<leader>tml", function()
  if _G.tmux_utils and _G.tmux_utils.list_sessions then
    _G.tmux_utils.list_sessions()
  end
end, { desc = "List tmux sessions" })

-- Window resize operations
km.set("n", "<leader>tmw+", function()
  if _G.tmux_utils and _G.tmux_utils.resize_pane then
    _G.tmux_utils.resize_pane("up")
  end
end, { desc = "Resize pane up" })

km.set("n", "<leader>tmw-", function()
  if _G.tmux_utils and _G.tmux_utils.resize_pane then
    _G.tmux_utils.resize_pane("down")
  end
end, { desc = "Resize pane down" })

km.set("n", "<leader>tmw<", function()
  if _G.tmux_utils and _G.tmux_utils.resize_pane then
    _G.tmux_utils.resize_pane("left")
  end
end, { desc = "Resize pane left" })

km.set("n", "<leader>tmw>", function()
  if _G.tmux_utils and _G.tmux_utils.resize_pane then
    _G.tmux_utils.resize_pane("right")
  end
end, { desc = "Resize pane right" })

-- Tmux splits
km.set("n", "<leader>tmh", function()
  if _G.tmux_utils and _G.tmux_utils.new_split then
    _G.tmux_utils.new_split("vertical")
  end
end, { desc = "Horizontal tmux split" })

km.set("n", "<leader>tmv", function()
  if _G.tmux_utils and _G.tmux_utils.new_split then
    _G.tmux_utils.new_split("horizontal")
  end
end, { desc = "Vertical tmux split" })

-- Session management
km.set("n", "<leader>tms", ":!tmux new-session -d -s<space>", { desc = "Create new tmux session" })
km.set("n", "<leader>tma", ":!tmux attach -t<space>", { desc = "Attach to tmux session" })
km.set("n", "<leader>tmL", ":!tmux list-sessions<CR>", { desc = "List tmux sessions" })

-- Terminal toggle (built-in)
km.set("n", "<leader>tt", function()
  if require("snacks") and require("snacks").terminal then
    require("snacks").terminal()
  end
end, { desc = "Toggle terminal" })

km.set("n", "<c-/>", function()
  if require("snacks") and require("snacks").terminal then
    require("snacks").terminal()
  end
end, { desc = "Toggle terminal" })

return {}
