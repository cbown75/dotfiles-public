local km = vim.keymap

-- Core operations
km.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
km.set("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
km.set("n", ",", ":w<CR>", { desc = "Quick save" })

-- Exit insert mode alternative
km.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Exit terminal mode
km.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Better navigation
km.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
km.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
km.set("n", "n", "nzzzv", { desc = "Next search result and center" })
km.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Clipboard operations (with original d for delete)
km.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
km.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
km.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })      -- Restored
km.set({ "n", "v" }, "<leader>D", '"+D', { desc = "Delete line to system clipboard" }) -- Restored
km.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard (after)" })
km.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

-- File operations
km.set("n", "<leader>f", "<nop>", { desc = "File Operations" })
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
end, { desc = "Fuzzily search in current buffer" })
km.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find open buffers" })

-- Buffer operations
km.set("n", "<leader>b", "<nop>", { desc = "Buffer Operations" })
km.set("n", "<leader>bf", ":Telescope buffers<CR>", { desc = "Buffer list" })
km.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
km.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
km.set("n", "<leader>bd", function()
  require("snacks").bufdelete()
end, { desc = "Delete buffer" })

-- UI toggles - consistent keys
km.set("n", "<leader>u", "<nop>", { desc = "UI Toggles" })
km.set("n", "<leader>us", function()
  _G.toggle_spelling()
end, { desc = "Toggle spelling" })
km.set("n", "<leader>uw", function()
  _G.toggle_wrap()
end, { desc = "Toggle word wrap" })
km.set("n", "<leader>ur", function()
  _G.toggle_relative_number()
end, { desc = "Toggle relative numbers" }) -- Changed from uL to ur
km.set("n", "<leader>ud", function()
  _G.toggle_diagnostics()
end, { desc = "Toggle diagnostics" })
km.set("n", "<leader>ul", function()
  _G.toggle_line_number()
end, { desc = "Toggle line numbers" })
km.set("n", "<leader>uc", function()
  _G.toggle_conceal()
end, { desc = "Toggle conceal" })
km.set("n", "<leader>ut", function()
  _G.toggle_treesitter()
end, { desc = "Toggle treesitter" }) -- Changed from uT to ut
km.set("n", "<leader>ub", function()
  _G.toggle_background()
end, { desc = "Toggle background" })
km.set("n", "<leader>uh", function()
  _G.toggle_inlay_hints()
end, { desc = "Toggle inlay hints" })
km.set("n", "<leader>ui", function()
  _G.toggle_indent()
end, { desc = "Toggle indent guides" }) -- Changed from ug to ui
km.set("n", "<leader>um", function()
  _G.toggle_dim()
end, { desc = "Toggle dim mode" }) -- Changed from uD to um
km.set("n", "<leader>un", function()
  require("snacks").notifier.hide()
end, { desc = "Dismiss Notifications" })
km.set("n", "<leader>up", "<cmd>Telescope colors<CR>", { desc = "Color picker" }) -- Changed from uC to up

-- Navigation aids
km.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "File Explorer" })

-- Todo comment navigation
km.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
km.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Miscellaneous utilities
km.set("n", "<leader>m", "<nop>", { desc = "Miscellaneous" })
km.set("n", "<leader>mf", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format with conform" }) -- Changed from mp to mf

-- Snippet management
km.set("n", "<leader>s", "<nop>", { desc = "Snippets/Search" })
km.set("n", "<leader>se", ":SnippetEdit<CR>", { desc = "Edit snippets for current filetype" })

-- Show which-key buffer-specific mappings
km.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Add date insertion (moved to miscellaneous)
km.set("n", "<leader>md", function()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end, { desc = "Insert Date" })

return {}
