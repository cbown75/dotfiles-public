-- Load all keymaps from the organized structure
local M = {}

-- Define which keymap modules to load and in what order
local modules = {
  "core",      -- Core editor functionality
  "navigation", -- Window and navigation
  "lsp",       -- LSP and diagnostics
  "git",       -- Git operations
  "ai",        -- AI assistant
  "devops",    -- Overall DevOps functionality
  "kubernetes", -- Kubernetes specific
  "terraform", -- New dedicated terraform module
  "docker",    -- New dedicated docker module
  "aws",       -- New dedicated AWS module
  "python",    -- New dedicated Python module
  "tmux",      -- Terminal and tmux
}

-- Custom require function to safely load modules
local function safe_require(module)
  local ok, loaded_module = pcall(require, "config.keymaps." .. module)
  if not ok then
    vim.notify("Could not load keymap module: " .. module, vim.log.levels.WARN)
    return nil
  end
  return loaded_module
end

-- Load all modules
function M.setup()
  for _, module in ipairs(modules) do
    safe_require(module)
  end
end

return M
