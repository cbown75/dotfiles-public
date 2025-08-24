return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- DevOps & Infrastructure
					"bashls", -- Bash/Shell scripts ✅
					"terraformls", -- Terraform
					"tflint", -- Terraform linting
					"helm_ls", -- Helm charts
					"yamlls", -- YAML (K8s, Ansible, etc.)
					"dockerls", -- Dockerfile
					"docker_compose_language_service", -- Docker Compose

					-- Programming Languages
					"lua_ls", -- Lua
					"gopls", -- Go
					"golangci_lint_ls", -- Go linting
					"rust_analyzer", -- Rust
					"ruff", -- Python (fast linter)

					-- Data & Config Formats
					"jsonls", -- JSON
					"jqls", -- jq (JSON query)
					"marksman", -- Markdown

					-- Web (commented out as you had them)
					--"html",
					--"nil_ls",
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true, -- not the same as ensure_installed
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
		},
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-8" }
			local lspconfig = require("lspconfig")

			-- Web & Frontend
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Programming Languages
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Recognize vim global in Neovim configs
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			-- DevOps & Infrastructure - THE MISSING ONES!
			lspconfig.bashls.setup({
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh" },
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.helm_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = {
							-- Kubernetes schemas
							["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.{yml,yaml}",
							-- Docker Compose
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							-- GitHub Actions
							["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
							-- Ansible
							["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-playbook.json"] = "*playbook*.{yml,yaml}",
						},
						validate = true,
						completion = true,
					},
				},
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})

			-- Additional DevOps tools
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
		end,
	},
}
