local km = vim.keymap

-- Clear existing keymaps in specific modes
-- Use this carefully as it removes ALL keymaps in the specified mode
-- vim.api.nvim_set_keymap('n', '', '', { noremap = true })

-- Core operations
km.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
km.set("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
km.set("n", ",", ":w<CR>", { desc = "Quick save" })

-- Exit insert mode alternative
km.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Exit terminal mode
km.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
km.set("n", "<C-h>", function()
  require("tmux").move_left()
end, { desc = "Go to left pane" })
km.set("n", "<C-j>", function()
  require("tmux").move_down()
end, { desc = "Go to lower pane" })
km.set("n", "<C-k>", function()
  require("tmux").move_up()
end, { desc = "Go to upper pane" })
km.set("n", "<C-l>", function()
  require("tmux").move_right()
end, { desc = "Go to right pane" })

-- Disable arrow keys to enforce hjkl usage
km.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
km.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
km.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
km.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Better navigation
km.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
km.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
km.set("n", "n", "nzzzv", { desc = "Next search result and center" })
km.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Clipboard operations
km.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
km.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
km.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })
km.set({ "n", "v" }, "<leader>D", '"+D', { desc = "Delete line to system clipboard" })
km.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard (after)" })
km.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

-- File operations
km.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
km.set(
  "n",
  "<leader>fg",
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Find text" }
)
km.set(
  "n",
  "<leader>fc",
  '<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
  { desc = "Find in code (no tests)" }
)
km.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
km.set("n", "<leader>fs", ":w<CR>", { desc = "Save file" })
km.set("n", "<leader>fw", ":wa<CR>", { desc = "Save all files" })
km.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
km.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
    layout_config = { width = 0.7 },
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Buffer operations
km.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "Buffer list" })
km.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
km.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
km.set("n", "<leader>bd", function()
  require("snacks").bufdelete()
end, { desc = "Delete buffer" })
km.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find open buffers" })

-- Tab management
km.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
km.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
km.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
km.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
km.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Window operations
km.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split vertically" })
km.set("n", "<leader>ws", ":split<CR>", { desc = "Split horizontally" })
km.set("n", "<leader>w=", "<C-w>=", { desc = "Equal window width" })
km.set("n", "<leader>w+", ":resize +5<CR>", { desc = "Increase window height" })
km.set("n", "<leader>w-", ":resize -5<CR>", { desc = "Decrease window height" })
km.set("n", "<leader>w>", ":vertical resize +5<CR>", { desc = "Increase window width" })
km.set("n", "<leader>w<", ":vertical resize -5<CR>", { desc = "Decrease window width" })
km.set("n", "<leader>ww", function()
  require("which-key").show({
    keys = "<c-w>",
    mode = "n",
    auto = false,
    loop = true,
  })
end, { desc = "Window hydra mode" })

-- Code operations
km.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
km.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format code" })
km.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
km.set("n", "<leader>ci", vim.lsp.buf.hover, { desc = "Code info/hover" })
km.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
km.set("n", "<leader>cR", function()
  require("snacks").rename.rename_file()
end, { desc = "Rename file" })

-- Go-to operations
km.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
km.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })

-- Diagnostics
km.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
km.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
km.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Search operations
km.set("n", "<leader>sr", function()
  require("spectre").open()
end, { desc = "Search and replace" })
km.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search symbols" })
km.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })
km.set("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Search TODO/FIX/FIXME" })
km.set("n", "<leader>sw", "<cmd>Telescope grep_string<CR>", { desc = "Search word under cursor" })
km.set("n", "<leader>sn", "<cmd>Telescope notify<CR>", { desc = "Search notifications" })

-- Trouble diagnostics
km.set("n", "<leader>xx", function()
  require("trouble").toggle()
end, { desc = "Toggle Trouble" })
km.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "Workspace diagnostics" })
km.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "Document diagnostics" })
km.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end, { desc = "Quickfix list" })
km.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end, { desc = "Location list" })
km.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end, { desc = "LSP references" })
km.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
km.set("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })

-- Git operations
km.set("n", "<leader>gb", function()
  require("snacks").git.blame_line()
end, { desc = "Git blame line" })
km.set({ "n", "v" }, "<leader>gB", function()
  require("snacks").gitbrowse()
end, { desc = "Git browse" })
km.set("n", "<leader>gh", function()
  require("snacks").lazygit.log_file()
end, { desc = "Git file history" })
km.set("n", "<leader>gg", function()
  require("snacks").lazygit()
end, { desc = "Lazygit" })
km.set("n", "<leader>gl", function()
  require("snacks").lazygit.log()
end, { desc = "Git log" })
km.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
km.set("n", "<leader>gf", "<cmd>Telescope git_bcommits<CR>", { desc = "Git buffer commits" })
km.set("n", "<leader>gi", "<cmd>AdvancedGitSearch<CR>", { desc = "Advanced Git search" })

-- Toggle/UI operations
km.set("n", "<leader>tt", function()
  require("snacks").terminal()
end, { desc = "Toggle terminal" })
km.set("n", "<c-/>", function()
  require("snacks").terminal()
end, { desc = "Toggle terminal" })
km.set("n", "<c-_>", function()
  require("snacks").terminal()
end, { desc = "which_key_ignore" })
km.set("n", "<leader>tu", "<cmd>Telescope undo<CR>", { desc = "Undo history" })
km.set("n", "<leader>z", function()
  require("snacks").zen()
end, { desc = "Toggle Zen Mode" })
km.set("n", "<leader>Z", function()
  require("snacks").zen.zoom()
end, { desc = "Toggle Zoom" })
km.set("n", "<leader>.", function()
  require("snacks").scratch()
end, { desc = "Toggle Scratch Buffer" })
km.set("n", "<leader>S", function()
  require("snacks").scratch.select()
end, { desc = "Select Scratch Buffer" })
km.set("n", "<leader>n", function()
  require("snacks").notifier.show_history()
end, { desc = "Notification History" })
km.set("n", "<leader>N", function()
  require("snacks").win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })

-- UI toggles using globally defined toggle functions from snacks.lua
km.set("n", "<leader>us", function() _G.toggle_spelling() end, { desc = "Toggle spelling" })
km.set("n", "<leader>uw", function() _G.toggle_wrap() end, { desc = "Toggle word wrap" })
km.set("n", "<leader>uL", function() _G.toggle_relative_number() end, { desc = "Toggle relative numbers" })
km.set("n", "<leader>ud", function() _G.toggle_diagnostics() end, { desc = "Toggle diagnostics" })
km.set("n", "<leader>ul", function() _G.toggle_line_number() end, { desc = "Toggle line numbers" })
km.set("n", "<leader>uc", function() _G.toggle_conceal() end, { desc = "Toggle conceal" })
km.set("n", "<leader>uT", function() _G.toggle_treesitter() end, { desc = "Toggle treesitter" })
km.set("n", "<leader>ub", function() _G.toggle_background() end, { desc = "Toggle background" })
km.set("n", "<leader>uh", function() _G.toggle_inlay_hints() end, { desc = "Toggle inlay hints" })
km.set("n", "<leader>ug", function() _G.toggle_indent() end, { desc = "Toggle indent guides" })
km.set("n", "<leader>uD", function() _G.toggle_dim() end, { desc = "Toggle dim mode" })
km.set("n", "<leader>un", function()
  require("snacks").notifier.hide()
end, { desc = "Dismiss Notifications" })
km.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", { desc = "Color picker" })

-- Avante AI (Claude) Integration
km.set("n", "<leader>aa", "<cmd>AvanteChat<cr>", { desc = "New Avante chat" })
km.set("n", "<leader>ac", "<cmd>AvanteClear<cr>", { desc = "Avante Clear" })
km.set("n", "<leader>af", "<cmd>AvanteFocus<cr>", { desc = "Avante Focus" })
km.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
km.set("n", "<leader>am", "<cmd>AvanteModels<cr>", { desc = "Avante Models" })
km.set("v", "<leader>as", function()
  require("avante").selection()
end, { desc = "Ask Avante about selection" })
km.set("v", "<leader>ai", function()
  require("avante").improve_selection()
end, { desc = "Improve selection with Avante" })
km.set("v", "<leader>ae", function()
  require("avante").explain_selection()
end, { desc = "Explain selection with Avante" })

-- Navigation aids
km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })
km.set("n", "<leader>xb", function()
  require("nvim-navbuddy").open()
end, { desc = "Nav Buddy" })
km.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "File Explorer" })

-- Todo comment navigation
km.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
km.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Treesitter textobjects
-- These are set via the treesitter-textobjects plugin directly and don't need explicit keymaps

-- Miscellaneous utilities
km.set("n", "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format with conform" })

-- Add date
km.set("n", "<leader>xd", function()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end, { desc = "Insert Date" })

-- Lazy update/sync
km.set("n", "<leader>lu", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })

-- Show buffer local keymaps in which-key
km.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
