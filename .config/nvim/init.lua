require("config.options")
require("config.lazy")
require("config.autocmd")
require("config.keymaps").setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Create global utility functions that can be used in keymaps
    _G.toggle_spelling = function()
      vim.wo.spell = not vim.wo.spell
      vim.notify("Spelling " .. (vim.wo.spell and "enabled" or "disabled"), vim.log.levels.INFO)
    end

    _G.toggle_wrap = function()
      vim.wo.wrap = not vim.wo.wrap
      vim.notify("Wrap " .. (vim.wo.wrap and "enabled" or "disabled"), vim.log.levels.INFO)
    end

    _G.toggle_relative_number = function()
      vim.wo.relativenumber = not vim.wo.relativenumber
      vim.notify("Relative number " .. (vim.wo.relativenumber and "enabled" or "disabled"), vim.log.levels.INFO)
    end

    _G.toggle_diagnostics = function()
      local state = vim.diagnostic.is_disabled()
      if state then
        vim.diagnostic.enable()
        vim.notify("Diagnostics enabled", vim.log.levels.INFO)
      else
        vim.diagnostic.disable()
        vim.notify("Diagnostics disabled", vim.log.levels.INFO)
      end
    end

    _G.toggle_line_number = function()
      vim.wo.number = not vim.wo.number
      vim.notify("Line numbers " .. (vim.wo.number and "enabled" or "disabled"), vim.log.levels.INFO)
    end

    _G.toggle_conceal = function()
      if vim.wo.conceallevel > 0 then
        vim.wo.conceallevel = 0
        vim.notify("Conceal disabled", vim.log.levels.INFO)
      else
        vim.wo.conceallevel = 2
        vim.notify("Conceal enabled", vim.log.levels.INFO)
      end
    end

    _G.toggle_treesitter = function()
      if vim.b.ts_highlight then
        vim.cmd("TSBufDisable highlight")
        vim.b.ts_highlight = false
        vim.notify("Treesitter highlighting disabled", vim.log.levels.INFO)
      else
        vim.cmd("TSBufEnable highlight")
        vim.b.ts_highlight = true
        vim.notify("Treesitter highlighting enabled", vim.log.levels.INFO)
      end
    end

    _G.toggle_background = function()
      if vim.o.background == "dark" then
        vim.o.background = "light"
      else
        vim.o.background = "dark"
      end
      vim.notify("Background set to " .. vim.o.background, vim.log.levels.INFO)
    end

    _G.toggle_inlay_hints = function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      vim.notify(
        "Inlay hints " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"),
        vim.log.levels.INFO
      )
    end

    _G.toggle_indent = function()
      if vim.g.indent_blankline_enabled then
        vim.g.indent_blankline_enabled = false
        vim.notify("Indent guides disabled", vim.log.levels.INFO)
      else
        vim.g.indent_blankline_enabled = true
        vim.notify("Indent guides enabled", vim.log.levels.INFO)
      end
    end

    _G.toggle_dim = function()
      if vim.g.dim_enabled then
        vim.g.dim_enabled = false
        vim.cmd("hi Normal guibg=NONE")
        vim.notify("Dim mode disabled", vim.log.levels.INFO)
      else
        vim.g.dim_enabled = true
        vim.cmd("hi Normal guibg=#1a1b26")
        vim.notify("Dim mode enabled", vim.log.levels.INFO)
      end
    end

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
