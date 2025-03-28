local km = vim.keymap

-- Session management
km.set("n", "<leader>Tf", function()
  _G.tmux_utils.find_session()
end, { desc = "Find tmux session" })
km.set("n", "<leader>Tn", function()
  _G.tmux_utils.new_session()
end, { desc = "New tmux session" })
km.set("n", "<leader>Tl", function()
  _G.tmux_utils.list_sessions()
end, { desc = "List tmux sessions" })

-- Window operations
km.set("n", "<leader>Tw+", function()
  _G.tmux_utils.resize_pane("up")
end, { desc = "Resize pane up" })
km.set("n", "<leader>Tw-", function()
  _G.tmux_utils.resize_pane("down")
end, { desc = "Resize pane down" })
km.set("n", "<leader>Tw<", function()
  _G.tmux_utils.resize_pane("left")
end, { desc = "Resize pane left" })
km.set("n", "<leader>Tw>", function()
  _G.tmux_utils.resize_pane("right")
end, { desc = "Resize pane right" })

-- Tmux splits
km.set("n", "<leader>Th", function()
  _G.tmux_utils.new_split("vertical")
end, { desc = "Horizontal tmux split" })
km.set("n", "<leader>Tv", function()
  _G.tmux_utils.new_split("horizontal")
end, { desc = "Vertical tmux split" })

-- Toggle session recording (if using vim-obsession)
km.set("n", "<leader>Tm", function()
  if _G.toggle_session_recording then
    _G.toggle_session_recording()
  else
    vim.cmd("Obsession")
  end
end, { desc = "Toggle tmux session recording" })

-- Tmux window/session management
km.set("n", "<leader>Ts", ":!tmux new-session -d -s<space>", { desc = "Create new tmux session" })
km.set("n", "<leader>Ta", ":!tmux attach -t<space>", { desc = "Attach to tmux session" })
km.set("n", "<leader>TL", ":!tmux list-sessions<CR>", { desc = "List tmux sessions" })

-- Tmux terminal in a specific pane
km.set("n", "<leader>Tt", ":silent !tmux split-window -h<CR>", { desc = "Horiz. terminal split" })
km.set("n", "<leader>Tv", ":silent !tmux split-window -v<CR>", { desc = "Vert. terminal split" })

return {}
