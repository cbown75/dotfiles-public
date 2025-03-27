vim.api.nvim_create_user_command("TmuxThemeSync", function()
  local colors = {
    bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#"),
    fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "fg#"),
    accent = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Special")), "fg#"),
    red = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Error")), "fg#"),
  }

  -- Generate tmux color commands
  local commands = {
    string.format("tmux set -g status-style bg=%s", colors.bg),
    string.format("tmux set -g pane-active-border-style fg=%s", colors.accent),
    string.format("tmux set -g pane-border-style fg=%s", colors.bg),
  }

  -- Apply commands
  for _, cmd in ipairs(commands) do
    vim.fn.system(cmd)
  end

  vim.notify("Tmux colors synced with Neovim", vim.log.levels.INFO)
end, {})
