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
					"ts_ls",
					"html",
					"bashls",
					"terraformls",
					"tflint",
					"helm_ls",
					"yamlls",
					"dockerls",
					"docker_compose_language_service",
					"lua_ls",
					"gopls",
					"golangci_lint_ls",
					"rust_analyzer",
					"ruff",
					"jsonls",
					"jqls",
					"marksman",
				},
				automatic_installation = true,
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

			-- Helper function to setup servers with the new API
			local function setup_server(name, config)
				config = config or {}
				config.capabilities = capabilities
				vim.lsp.config(name, config)
			end

			-- Web & Frontend
			setup_server("ts_ls", {})
			setup_server("html", {})

			-- Data & Config Formats
			setup_server("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			setup_server("jqls", {})

			-- Programming Languages
			setup_server("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
			setup_server("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					},
				},
			})
			setup_server("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})

			-- DevOps & Infrastructure
			setup_server("bashls", {
				filetypes = { "sh", "bash", "zsh" },
				settings = {
					bashIde = {
						globPattern = "*@(.sh|.inc|.bash|.command)",
					},
				},
			})
			setup_server("terraformls", {
				settings = {
					terraform = {
						validation = {
							enableEnhancedValidation = true,
						},
					},
				},
			})
			setup_server("helm_ls", {
				settings = {
					["helm-ls"] = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
			})
			setup_server("yamlls", {
				settings = {
					yaml = {
						schemas = {
							["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-playbook.json"] = "*playbook*.{yml,yaml}",
							["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
						},
						validate = true,
						completion = true,
					},
				},
			})
			setup_server("dockerls", {
				settings = {
					docker = {
						languageserver = {
							formatter = {
								ignoreMultilineInstructions = true,
							},
						},
					},
				},
			})
			setup_server("docker_compose_language_service", {})

			-- Documentation
			setup_server("marksman", {})
		end,
	},
}
