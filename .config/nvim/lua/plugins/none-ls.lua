return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {
        -- DevOps Linting/Diagnostics Tools
        "yamllint", -- YAML validation for K8s/Ansible
        "ansible-lint", -- Ansible playbook validation
        "terraform-ls", -- Terraform Language Server diagnostics
        "tflint",   -- Terraform linting
        "hadolint", -- Dockerfile linting
        "shellcheck", -- Shell script analysis

        -- Code Quality Tools
        "eslint_d",  -- JavaScript/TypeScript linting
        "ruff",      -- Python linting (fast)
        "golangci-lint", -- Go linting

        -- Remove formatters to avoid conflicts with conform.nvim
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")

    local sources = {
      -- DIAGNOSTICS & LINTING ONLY - No formatting to prevent conflicts

      -- DevOps Tools Diagnostics
      null_ls.builtins.diagnostics.yamllint.with({
        extra_args = { "-d", "relaxed" }, -- Less strict for DevOps YAML
      }),
      null_ls.builtins.diagnostics.hadolint, -- Dockerfile linting
      null_ls.builtins.diagnostics.terraform_validate,
      null_ls.builtins.diagnostics.shellcheck,

      -- Programming Languages Diagnostics
      require("none-ls.diagnostics.eslint_d"), -- JS/TS
      require("none-ls.diagnostics.ruff"),     -- Python
      null_ls.builtins.diagnostics.golangci_lint, -- Go

      -- Code Actions (non-formatting)
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.hover.dictionary,
    }

    require("null-ls").setup({
      sources = sources,
      -- REMOVED: on_attach with BufWritePre formatting to prevent conflicts
    })
  end,
}
