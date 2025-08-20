return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer", -- Complete from buffer text
	},
	{
		"hrsh7th/cmp-path", -- Complete file paths
	},
	{
		"hrsh7th/cmp-cmdline", -- Command line completion
	},
	{
		"davidsierradz/cmp-conventionalcommits", -- Git conventional commits
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"davidsierradz/cmp-conventionalcommits",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local icons = require("lib.icons") -- Your existing icons

			-- Better tab behavior with snippets
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- Source and field formatting
			local format_item = function(entry, vim_item)
				-- Source-specific text in menu
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snip]",
					buffer = "[Buf]",
					path = "[Path]",
					cmdline = "[Cmd]",
					conventionalcommits = "[Git]",
					supermaven = "[AI]", -- Added for Supermaven source
				})[entry.source.name]

				-- Add icons from your existing icon setup
				if icons.kind[vim_item.kind] then
					local icon = icons.kind[vim_item.kind]
					vim_item.kind = string.format("%s %s", icon, vim_item.kind)
				end

				-- Special case for DevOps-related completions - check filetype
				local filetype = vim.bo.filetype
				if filetype == "terraform" or filetype == "hcl" then
					if entry.source.name == "nvim_lsp" and vim_item.kind == "Resource" then
						vim_item.kind = string.format("%s %s", "󱁢", "Terraform")
					end
				elseif filetype == "yaml" or filetype == "yml" then
					-- Detect if it's a Kubernetes YAML
					local filename = vim.fn.expand("%:t")
					if
							filename:match("deployment")
							or filename:match("service")
							or filename:match("ingress")
							or filename:match("config")
					then
						vim_item.kind = string.format("%s %s", "󰠰", "K8s")
					end
				elseif filetype == "dockerfile" then
					vim_item.kind = string.format("%s %s", "󰡨", "Docker")
				end

				return vim_item
			end

			cmp.setup({
				-- Snippet support
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- Nicer windows
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel",
						scrollbar = false,
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:PmenuSel",
						scrollbar = false,
					}),
				},

				-- Performance tuning
				performance = {
					max_view_entries = 20, -- Limit displayed entries
					throttle = 50,    -- Time in ms to wait before filtering
					debounce = 100,   -- Debounce time for LSP requests
				},

				-- FIXED: Stable Tab mapping without LazyVim abstractions
				mapping = cmp.mapping.preset.insert({
					-- Documentation scrolling
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Completion control
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),

					-- FIXED: Explicit Tab behavior - no more conflicts
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- FIXED: Reliable confirmation
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false, -- Only confirm explicitly selected items
					}),
					["<C-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true, -- Accept first item if none selected
					}),
				}),

				-- Formatting setup
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = format_item,
				},

				-- FIXED: Source configuration with Supermaven integration
				sources = cmp.config.sources({
					{ name = "nvim_lsp",   priority = 1000, max_item_count = 20 },
					{ name = "supermaven", priority = 750,  max_item_count = 10 }, -- Supermaven as source
					{ name = "luasnip",    priority = 700,  max_item_count = 10 },
					{ name = "path",       priority = 500 },
				}, {
					{ name = "buffer", priority = 250, keyword_length = 3, max_item_count = 10 },
				}),

				-- FIXED: Always enable ghost text - no conditional logic
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},

				-- Better sorting for DevOps workflows
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						-- Special case for terraform/kubectl commands
						function(entry1, entry2)
							local e1 = entry1.completion_item.label
							local e2 = entry2.completion_item.label

							-- Devops specific enhancements
							local ft = vim.bo.filetype

							-- Terraform resource prioritization
							if ft == "terraform" or ft == "hcl" then
								local tf_prefix = '^(resource|data)%s+"'
								if e1:match(tf_prefix) and not e2:match(tf_prefix) then
									return true
								elseif not e1:match(tf_prefix) and e2:match(tf_prefix) then
									return false
								end

								-- Kubernetes resource prioritization
							elseif ft == "yaml" or ft == "yml" then
								local k8s_prefix = "^(kind|apiVersion):%s+"
								if e1:match(k8s_prefix) and not e2:match(k8s_prefix) then
									return true
								elseif not e1:match(k8s_prefix) and e2:match(k8s_prefix) then
									return false
								end
							end

							return nil
						end,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			-- Setup cmdline completion
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline", keyword_length = 1 },
				}),
			})

			-- Setup for search completion
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "buffer", keyword_length = 3 },
				}),
			})

			-- Setup specific file-type configurations
			-- Terraform
			cmp.setup.filetype({ "terraform", "hcl" }, {
				sources = cmp.config.sources({
					{ name = "nvim_lsp",   priority = 1000 },
					{ name = "supermaven", priority = 750 },
					{ name = "luasnip",    priority = 700 },
					{ name = "buffer",     priority = 500 },
					{ name = "path",       priority = 250 },
				}),
			})

			-- Kubernetes YAML
			cmp.setup.filetype({ "yaml", "yml" }, {
				sources = cmp.config.sources({
					{ name = "nvim_lsp",   priority = 1000 },
					{ name = "supermaven", priority = 750 },
					{ name = "luasnip",    priority = 700 },
					{ name = "buffer",     priority = 500 },
					{ name = "path",       priority = 250 },
				}),
			})

			-- Git commit messages
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "conventionalcommits", priority = 1000 },
					{ name = "buffer",              priority = 500 },
				}),
			})

			-- Shell scripts
			cmp.setup.filetype({ "sh", "bash", "zsh" }, {
				sources = cmp.config.sources({
					{ name = "nvim_lsp",   priority = 1000 },
					{ name = "supermaven", priority = 750 },
					{ name = "luasnip",    priority = 700 },
					{ name = "buffer",     priority = 500 },
					{ name = "path",       priority = 250 },
				}),
			})

			-- Register a buffer-specific configuration manager for Kubernetes files
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = { "*.yaml", "*.yml" },
				callback = function()
					local filename = vim.fn.expand("%:t")
					-- Check if this is a Kubernetes file
					if
							filename:match("deployment")
							or filename:match("service")
							or filename:match("ingress")
							or filename:match("configmap")
							or filename:match("kustomization")
					then
						-- Add a higher priority buffer source for K8s files
						cmp.setup.buffer({
							sources = cmp.config.sources({
								{ name = "nvim_lsp",   priority = 1000 },
								{ name = "supermaven", priority = 750 },
								{ name = "luasnip",    priority = 700 },
								{ name = "buffer",     priority = 650 }, -- Higher priority for K8s terms
								{ name = "path",       priority = 250 },
							}),
						})
					end
				end,
			})
		end,
	},
}
