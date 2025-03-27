return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		-- Define excluded filetypes here so we can access them directly
		local excluded_filetypes = {
			"help",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
			"noice",
		}

		-- Set up barbecue with custom configuration
		require("barbecue").setup({
			create_autocmd = false, -- prevent barbecue from updating itself automatically

			-- Performance optimization: exclude certain filetypes
			exclude_filetypes = excluded_filetypes,

			-- Skip large files
			show_modified = false, -- don't track buffer modified state for better performance

			-- Custom theme to match dracula
			theme = {
				normal = { fg = "#F8F8F2", bg = "#282A36" },
				context = { fg = "#8BE9FD" },
				separator = { fg = "#6272A4" },
			},

			-- Symbols for better visibility
			symbols = {
				separator = "➜",
			},
		})

		-- Create optimization variables
		local optimize = {
			is_scrolling = false,
			timer = vim.loop.new_timer(),
			last_update = 0,
			update_interval = 300, -- ms
			cached_contexts = {},
			max_file_size = 100 * 1024, -- Skip files larger than 100KB
		}

		-- Create a smarter update function that respects scrolling state
		local function smart_update()
			-- Get current buffer info
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.bo[bufnr].filetype

			-- Skip if filetype is in exclude list
			if vim.tbl_contains(excluded_filetypes, ft) then
				return
			end

			-- Skip large files
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
			if ok and stats and stats.size > optimize.max_file_size then
				return
			end

			-- Don't update while scrolling
			if optimize.is_scrolling then
				return
			end

			-- Throttle updates (don't update too frequently)
			local now = vim.loop.now()
			if now - optimize.last_update < optimize.update_interval then
				return
			end

			-- Update context
			require("barbecue.ui").update()
			optimize.last_update = now
		end

		-- Set up autocmd with optimizations
		vim.api.nvim_create_autocmd({
			"BufWinEnter",
			"CursorHold",
			"InsertLeave",
		}, {
			group = vim.api.nvim_create_augroup("barbecue.updater", {}),
			callback = smart_update,
		})

		-- Detect scrolling to disable updates during scroll
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = vim.api.nvim_create_augroup("barbecue.scroll_detection", {}),
			callback = function()
				optimize.is_scrolling = true

				-- Reset the timer if it's already running
				if optimize.timer then
					optimize.timer:stop()
				end

				-- After scrolling stops, wait a bit before updating
				optimize.timer:start(
					300,
					0,
					vim.schedule_wrap(function()
						optimize.is_scrolling = false
						smart_update() -- Update once after scrolling stops
					end)
				)
			end,
		})

		-- Add a command to manually force winbar update
		vim.api.nvim_create_user_command("BarbecueUpdate", function()
			require("barbecue.ui").update()
		end, {})
	end,
}
