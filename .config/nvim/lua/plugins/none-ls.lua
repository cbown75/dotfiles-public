return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        "ruff",
        "prettier",
        "shfmt",
        "yamlfmt",
        "isort",
        "black",
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")

    local sources = {
      require("none-ls.diagnostics.eslint_d"),
      require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
      require("none-ls.formatting.ruff_format"),
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with({ filetypes = { "json", "markdown", "css", "html" } }),
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }),
      null_ls.builtins.formatting.terraform_fmt,
      null_ls.builtins.formatting.yamlfmt,
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    require("null-ls").setup({
      on_init = function(client)
        client.offset_encoding = "utf-8"
      end,
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
    })
  end,
}
