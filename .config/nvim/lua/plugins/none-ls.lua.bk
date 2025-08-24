return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {
				-- Only install tools that are working from your health check
				"yamllint", -- ✅ Working
				-- Remove "hadolint" since it's not executable
			},
			automatic_installation = false, -- Prevent auto-install errors
		})

		local null_ls = require("null-ls")

		local sources = {
			-- DIAGNOSTICS ONLY - No formatting to prevent conflicts

			-- ✅ Working tools from your health check
			null_ls.builtins.diagnostics.yamllint.with({
				extra_args = { "-d", "relaxed" }, -- Less strict for DevOps YAML
			}),

			-- ✅ Terraform validation (terraform command is available)
			null_ls.builtins.diagnostics.terraform_validate,

			-- Add shellcheck if it's available (probably is)
			null_ls.builtins.diagnostics.shellcheck,
			null_ls.builtins.code_actions.shellcheck,

			-- JavaScript/TypeScript diagnostics (if none-ls-extras works)
			require("none-ls.diagnostics.eslint_d"),

			-- Always available utilities
			null_ls.builtins.hover.dictionary,

			-- REMOVED: hadolint (not executable according to health check)
			-- Add it back later with: brew install hadolint
		}

		require("null-ls").setup({
			sources = sources,
		})
	end,
}
