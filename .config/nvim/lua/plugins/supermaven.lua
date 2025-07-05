return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter", -- loads only when you start typing
  config = function()
    require("supermaven-nvim").setup({
      ignore_filetypes = { "markdown", "text" }, -- skip AI for these
    })
  end,
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        -- Optional: only add Supermaven source when AI is enabled
        if vim.g.ai_cmp then
          table.insert(opts.sources, 1, {
            name = "supermaven",
            group_index = 1,
            priority = 100,
          })
        end
      end,
    },
  },
}
