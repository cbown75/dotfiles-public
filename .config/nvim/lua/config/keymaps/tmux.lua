local km = vim.keymap

-- TMUX group
km.set("n", "<leader>tm", "<nop>", { desc = "Tmux Operations" })

-- Terminal operations
km.set("n", "<leader>tn", ":terminal<CR>", { desc = "New terminal (horizontal)" })
km.set("n", "<leader>tv", ":vnew | terminal<CR>", { desc = "New terminal (vertical)" })

-- Toggle terminal (single option to avoid duplicates)
km.set("n", "<leader>tt", function()
  if require("snacks") and require("snacks").terminal then
    require("snacks").terminal()
  end
end, { desc = "Toggle terminal" })

-- Use <c-/> as alternate binding for toggle terminal
km.set("n", "<c-/>", function()
  if require("snacks") and require("snacks").terminal then
    require("snacks").terminal()
  end
end, { desc = "Toggle terminal" })

-- Tmux integration (under the tmux prefix)
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

-- Window resize operations (under tmux prefix for consistency)
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

-- Tab operations - move to their own prefix
km.set("n", "<leader>ta", "<nop>", { desc = "Tab Operations" })
km.set("n", "<leader>tao", "<cmd>tabnew<CR>", { desc = "Open new tab" })
km.set("n", "<leader>tax", "<cmd>tabclose<CR>", { desc = "Close current tab" })
km.set("n", "<leader>tan", "<cmd>tabn<CR>", { desc = "Go to next tab" })
km.set("n", "<leader>tap", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
km.set("n", "<leader>taf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

return {}
