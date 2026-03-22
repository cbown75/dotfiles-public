require("config.options")
require("config.lazy")
require("config.autocmd")
require("config.keymaps").setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Toggle functions are provided by snacks.nvim (see plugins/snacks.lua)

    -- Define snippet helpers for use in different snippets
    _G.luasnip_helpers = {
      -- Expand snippet or jump to next placeholder
      expand_or_jump = function()
        local luasnip = require("luasnip")
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end,

      -- Jump to previous placeholder
      jump_prev = function()
        local luasnip = require("luasnip")
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end,

      -- Cycle through choices for a choice node
      change_choice = function(delta)
        local luasnip = require("luasnip")
        if luasnip.choice_active() then
          luasnip.change_choice(delta)
        end
      end,

      -- Python print statement with variable introspection
      py_print = function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local word = vim.fn.expand("<cword>")
        local result

        if word and word ~= "" then
          result = string.format('print(f"%s = {%s}")', word, word)
        else
          result = 'print(f"")'
        end

        vim.api.nvim_put({ result }, "c", true, true)
      end,
    }

    -- Apply safe patches for treesitter use
    if vim.fn.exists(":TSInstall") == 1 then
      -- Check for important missing parsers
      local parsers = {
        "regex", -- Required by noice.nvim
        "yaml", -- For Kubernetes/Docker files
        "hcl", -- For Terraform files
      }

      for _, parser in ipairs(parsers) do
        vim.cmd("silent! TSInstall " .. parser)
      end
    end
  end,
})
