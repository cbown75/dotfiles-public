return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter", -- loads only when you start typing
  config = function()
    require("supermaven-nvim").setup({
      -- FIXED: Disable conflicting features to prevent Tab key issues
      disable_inline_completion = true, -- Prevents ghost text conflicts with nvim-cmp
      disable_keymaps = true,        -- Prevents Tab key conflicts

      -- Keep these settings for when used as cmp source
      ignore_filetypes = { "markdown", "text" }, -- skip AI for these

      -- Optional: Configure logging if you need debugging
      log_level = "info", -- "off", "info", "warn", "error"

      -- Color customization (optional)
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
    })
  end,
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        -- FIXED: Only add Supermaven source when AI is enabled and configured properly
        if vim.g.ai_cmp ~= false then -- Allow both true and nil (default)
          table.insert(opts.sources, 1, {
            name = "supermaven",
            group_index = 1,
            priority = 750, -- High priority but below LSP
            max_item_count = 10, -- Limit to prevent overwhelming
          })
        end
      end,
    },
  },
}
