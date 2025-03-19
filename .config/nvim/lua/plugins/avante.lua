return {
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
    },
    build = "make",
    version = "*",
    lazy = false,
    keys = {
      { "<leader>aa", "<cmd>avantechatnew<cr>", desc = "new avante chat" },
      { "<leader>at", "<cmd>avantetoggle<cr>",  desc = "toggle avante" },
      {
        "<leader>as",
        function()
          require("avante").selection()
        end,
        desc = "ask avante about selection",
        mode = { "v" },
      },
      {
        "<leader>ai",
        function()
          require("avante").improve_selection()
        end,
        desc = "improve selection with avante",
        mode = { "v" },
      },
      {
        "<leader>ae",
        function()
          require("avante").explain_selection()
        end,
        desc = "explain selection with avante",
        mode = { "v" },
      },
    },
    init = function()
      -- Get API key once to avoid multiple system calls
      local api_key_cmd = "security find-generic-password -s 'anthropic_api_key' -w 2>/dev/null"
      local api_key_result = vim.fn.systemlist(api_key_cmd)

      -- Check if we successfully retrieved the API key
      if vim.v.shell_error == 0 and #api_key_result > 0 then
        local api_key = api_key_result[1]
        -- Set global variables before the plugin loads
        vim.g.avante_api_key = api_key
        vim.env.ANTHROPIC_API_KEY = api_key
      else
        vim.notify("Failed to retrieve Anthropic API key from keychain", vim.log.levels.ERROR)
      end
    end,
    config = function()
      -- Use the already set environment variable
      local api_key = vim.env.ANTHROPIC_API_KEY

      if not api_key or api_key == "" then
        vim.notify("Anthropic API key not found. Avante may not work correctly.", vim.log.levels.WARN)
        return
      end

      require("avante").setup({
        anthropic_api_key = api_key,
        -- Current model as of March 2025
        model = "claude-3-7-sonnet-20250219",
        system_message = [[You are Claude, a helpful AI assistant created by Anthropic.
        You excel at programming, especially in Neovim and Lua.
        When asked coding questions, you provide clear, concise code with explanations.
        You help users improve their workflow, fix bugs, and implement new features.]],
      })
    end,
  },
}
