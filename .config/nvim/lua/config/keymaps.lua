-- Load all keymaps from the organized structure
local M = {}

-- Custom require function to safely load modules
local function safe_require(module)
  local ok, loaded_module = pcall(require, module)
  if not ok then
    vim.notify("Could not load keymap module: " .. module, vim.log.levels.WARN)
    return nil
  end
  return loaded_module
end

-- Core editor functionality
safe_require("config.keymaps.core")

-- DevOps and tools
safe_require("config.keymaps.devops")
safe_require("config.keymaps.kubernetes")
safe_require("config.keymaps.terminal")

-- Programming and code navigation
safe_require("config.keymaps.lsp")
safe_require("config.keymaps.git")
safe_require("config.keymaps.ai")

-- Window and navigation
safe_require("config.keymaps.navigation")

return M
