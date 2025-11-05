local M = {}

function M.load()
  require("config.keymaps.core")
  require("config.keymaps.devops")
  require("config.keymaps.kubernetes")
  require("config.keymaps.git")
  require("config.keymaps.opencode")
  require("config.keymaps.lsp")
  require("config.keymaps.navigation")
  require("config.keymaps.tmux")
  require("config.keymaps.oil")
end

return M
