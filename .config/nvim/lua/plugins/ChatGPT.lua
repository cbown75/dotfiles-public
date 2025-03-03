return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      -- Function to get API key from macOS Keychain using your shell function
      local function get_anthropic_key_from_shell()
        local handle = io.popen("get_anthropic_key")
        if handle then
          local result = handle:read("*a")
          handle:close()
          -- Remove trailing newline
          return result:gsub("\n$", "")
        end
        return nil
      end

      require("chatgpt").setup({
        -- Use your shell function to get the API key
        api_key_cmd = "get_anthropic_key",

        -- Claude configuration
        anthropic = {
          api_url_messages = "https://api.anthropic.com/v1/messages",
          -- Using the key directly from the function
          api_key = get_anthropic_key_from_shell(),
          model = "claude-3-7-sonnet-20250219",
          messages_params = {
            max_tokens = 4000,
            temperature = 0.7,
          },
          api_headers = function(api_key)
            return {
              ["x-api-key"] = api_key,
              ["content-type"] = "application/json",
              ["anthropic-version"] = "2023-06-01",
            }
          end,
        },

        -- Enable Anthropic API (Claude) instead of OpenAI
        api_provider = "anthropic",

        -- Rest of your configuration...
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
        },

        -- Keybindings
        keymaps = {
          close = { "<C-c>", "q" },
          submit = "<C-Enter>",
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
        },
      })
    end,
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<CR>",                       desc = "ChatGPT" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>",    desc = "Edit with instruction", mode = { "n", "v" } },
      { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction",    mode = { "n", "v" } },
      { "<leader>ct", "<cmd>ChatGPTRun translate<CR>",          desc = "Translate",             mode = { "n", "v" } },
      { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>",          desc = "Summarize",             mode = { "n", "v" } },
      { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>",          desc = "Docstring",             mode = { "n", "v" } },
      { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>",      desc = "Optimize Code",         mode = { "n", "v" } },
    },
  }
}
