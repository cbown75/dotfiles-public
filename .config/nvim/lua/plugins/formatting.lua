return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- DevOps Infrastructure as Code
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        hcl = { "terraform_fmt" },

        -- Kubernetes & Helm
        yaml = { "yamlfmt" },
        ["yaml.ansible"] = { "yamlfmt" },
        helm = { "yamlfmt" },

        -- Container & Docker
        dockerfile = { "prettier" },

        -- Shell & Scripts
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- Programming Languages
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },

        -- Web/Config formats
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        markdown = { "prettier" },

        -- Additional DevOps formats
        toml = { "taplo" },
        ["gitignore"] = { "prettier" },
      },

      -- Configure formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "4" }, -- 4 spaces for shell scripts
        },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000, -- Increased timeout for complex files
        quiet = true,  -- Suppress formatting messages
      },
    })

    -- Optional: Add a manual format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      conform.format({ async = true, lsp_fallback = true, range = range })
    end, { range = true, desc = "Format code" })
  end,
}
