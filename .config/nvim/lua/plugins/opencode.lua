return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {},
  config = function(_, opts)
    vim.o.autoread = true
    require("opencode").setup(opts)
  end,
}
