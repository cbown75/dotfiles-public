return {
	"christoomey/vim-tmux-navigator", -- Use this for navigation between panes
	lazy = false,
	config = function()
		-- Create tmux utilities
		_G.tmux_utils = {
			-- Resize tmux pane in a direction
			resize_pane = function(direction)
				local commands = {
					up = "resize-pane -U 5",
					down = "resize-pane -D 5",
					left = "resize-pane -L 5",
					right = "resize-pane -R 5",
				}

				local cmd = commands[direction]
				if cmd then
					vim.fn.system("tmux " .. cmd)
				end
			end,

			-- Create a new tmux split
			new_split = function(orientation)
				local cmd = orientation == "vertical" and "split-window -h" or "split-window -v"
				vim.fn.system("tmux " .. cmd)
			end,

			-- List tmux sessions
			list_sessions = function()
				local output = vim.fn.system("tmux list-sessions")
				print(output)
			end,

			-- Find and switch to a session
			find_session = function()
				-- Check if we're in tmux
				if vim.env.TMUX == nil then
					vim.notify("Not running inside tmux", vim.log.levels.WARN)
					return
				end

				-- Get list of sessions
				local handle = io.popen("tmux list-sessions -F '#S'")
				if not handle then
					vim.notify("Failed to get tmux sessions", vim.log.levels.ERROR)
					return
				end

				local sessions = {}
				for session in handle:lines() do
					table.insert(sessions, session)
				end
				handle:close()

				-- Use vim.ui.select to choose a session
				vim.ui.select(sessions, {
					prompt = "Select Tmux Session:",
					format_item = function(item)
						return item
					end,
				}, function(choice)
					if choice then
						-- Switch to the selected session
						os.execute("tmux switch-client -t " .. choice)
						vim.notify("Switched to session: " .. choice, vim.log.levels.INFO)
					end
				end)
			end,

			-- Create a new session
			new_session = function()
				vim.ui.input({
					prompt = "New session name: ",
				}, function(input)
					if input and input ~= "" then
						os.execute("tmux new-session -d -s " .. input)
						os.execute("tmux switch-client -t " .. input)
						vim.notify("Created and switched to session: " .. input, vim.log.levels.INFO)
					end
				end)
			end,
		}
	end,
}
