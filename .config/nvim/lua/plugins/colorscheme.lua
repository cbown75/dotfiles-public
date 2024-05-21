-- return {
--   {
--     "catppuccin/nvim",
--     lazy = false,
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme "catppuccin-mocha"
--     end
--   }
-- }


return {
  "binhtran432k/dracula.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme "dracula"
  end
}
