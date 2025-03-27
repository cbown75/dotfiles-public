return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- Use classic preset for most traditional setup
    preset = "classic",
    -- Delay before showing the popup
    delay = 200,
    -- Icons configuration
    icons = {
      breadcrumb = "»", -- symbol used in the command line area
      separator = "➜", -- symbol used between a key and its label
      group = "+", -- symbol prepended to a group
    },
    -- Popup window configuration
    win = {
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      border = "single",
      title = true,
      title_pos = "center",
    },
    -- Layout configuration
    layout = {
      width = { min = 20 }, -- min width of the columns
      spacing = 3,          -- spacing between columns
    },
    -- Key behavior
    keys = {
      scroll_down = "<c-d>", -- scroll down in the popup
      scroll_up = "<c-u>",   -- scroll up in the popup
    },
    -- Plugins configuration
    plugins = {
      marks = true,       -- shows marks on ' and `
      registers = true,   -- shows registers on " in NORMAL or <C-r> in INSERT
      spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z=
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true,    -- adds help for operators like d, y, ...
        motions = true,      -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true,      -- default bindings on <c-w>
        nav = true,          -- misc bindings to work with windows
        z = true,            -- bindings for folds, spelling and others prefixed with z
        g = true,            -- bindings for prefixed with g
      },
    },
    show_help = true, -- show help message in the command line
    show_keys = true, -- show the currently pressed key and its label
    triggers = {
      -- Automatically setup triggers
      { "<auto>", mode = "nxso" },
    },
    disable = {
      ft = {},
      bt = {},
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Add keymappings using the new add method
    wk.add({
      -- Main groups with descriptions
      { "<leader>a", group = "󱠁 AI Assistant", desc = "AI assistance with Claude" },
      { "<leader>b", group = "󰓩 Buffer", desc = "Buffer management" },
      { "<leader>c", group = "󰅱 Code", desc = "Code actions and editing" },
      { "<leader>d", group = "󰃤 Debug", desc = "Debugging operations" },
      { "<leader>f", group = "󰈔 File/Find", desc = "File operations and search" },
      { "<leader>g", group = "󰊢 Git/Go-to", desc = "Git operations and navigation" },
      { "<leader>l", group = "󰒲 Lazy", desc = "Lazy plugin manager" },
      { "<leader>m", group = "󰍘 Misc", desc = "Miscellaneous tools" },
      { "<leader>p", group = "󰏗 Project", desc = "Project-wide operations" },
      { "<leader>s", group = "󱘧 Search", desc = "Search operations" },
      { "<leader>t", group = "󰍉 Tab/Terminal", desc = "Tab & terminal management" },
      { "<leader>u", group = "󰒓 UI Toggle", desc = "Toggle UI features" },
      { "<leader>w", group = "󱂬 Window", desc = "Window management" },
      { "<leader>x", group = "󰁨 Diagnostics/Utilities", desc = "Diagnostics & utilities" },
      { "[", group = "Previous", desc = "Navigate to previous items" },
      { "]", group = "Next", desc = "Navigate to next items" },
      { "g", group = "Go to", desc = "Go to locations" },

      -- Core operations
      { "<Esc>", desc = "Clear highlights" },
      { "<leader><leader>", desc = "Find files" },
      { ",", desc = "Quick save" },

      -- Basic operations
      { "jj", desc = "Exit insert mode", mode = "i" },
      { "<Esc><Esc>", desc = "Exit terminal mode", mode = "t" },

      -- Window navigation
      { "<C-h>", desc = "Go to left pane" },
      { "<C-j>", desc = "Go to lower pane" },
      { "<C-k>", desc = "Go to upper pane" },
      { "<C-l>", desc = "Go to right pane" },

      -- Better navigation
      { "<C-d>", desc = "Half page down and center" },
      { "<C-u>", desc = "Half page up and center" },
      { "n", desc = "Next search result and center" },
      { "N", desc = "Previous search result and center" },

      -- Clipboard operations - grouped by frequency of use
      { "<leader>y", desc = "Yank to system clipboard", mode = { "n", "v" } },
      { "<leader>p", desc = "Paste from system clipboard (after)" },
      { "<leader>P", desc = "Paste from system clipboard (before)" },
      { "<leader>Y", desc = "Yank line to system clipboard", mode = { "n", "v" } },
      { "<leader>d", desc = "Delete to system clipboard", mode = { "n", "v" } },
      { "<leader>D", desc = "Delete line to system clipboard", mode = { "n", "v" } },
    })

    -- File operations submenu with description
    wk.add({
      { "<leader>f",  group = "File Operations",                desc = "Operations for finding and managing files" },
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Find text" },
      { "<leader>fc", desc = "Find in code (no tests)" },
      { "<leader>fr", desc = "Recent files" },
      { "<leader>fs", desc = "Save file" },
      { "<leader>fw", desc = "Save all files" },
      { "<leader>fk", desc = "Find keymaps" },
      { "<leader>/",  desc = "Fuzzily search in current buffer" },
      { "<leader>fb", desc = "Find open buffers" },
    })

    -- Buffer operations submenu with description
    wk.add({
      { "<leader>b",  group = "Buffer Operations", desc = "Operations for managing buffers" },
      { "<leader>bf", desc = "Buffer list" },
      { "<leader>bn", desc = "Next buffer" },
      { "<leader>bp", desc = "Previous buffer" },
      { "<leader>bd", desc = "Delete buffer" },
    })

    -- Tab management submenu with description
    wk.add({
      { "<leader>t",  group = "Tab/Terminal Operations",      desc = "Operations for tabs and terminal" },
      { "<leader>to", desc = "Open new tab" },
      { "<leader>tx", desc = "Close current tab" },
      { "<leader>tn", desc = "Go to next tab" },
      { "<leader>tp", desc = "Go to previous tab" },
      { "<leader>tf", desc = "Open current buffer in new tab" },
      { "<leader>tt", desc = "Toggle terminal" },
      { "<leader>tu", desc = "Undo history" },
    })

    -- Window operations - use hydra-like functionality
    wk.add({
      { "<leader>w", group = "Window Operations", desc = "Operations for managing windows (press again for more)" },
    })

    -- Window operations hydra
    -- This will keep the menu open after the first w press
    local function window_hydra()
      local hydra_keys = {
        v = { ":vsplit<CR>", "Split vertically" },
        s = { ":split<CR>", "Split horizontally" },
        ["="] = { "<C-w>=", "Equal window width" },
        ["+"] = { ":resize +5<CR>", "Increase window height" },
        ["-"] = { ":resize -5<CR>", "Decrease window height" },
        [">"] = { ":vertical resize +5<CR>", "Increase window width" },
        ["<"] = { ":vertical resize -5<CR>", "Decrease window width" },
        h = { "<C-w>h", "Move to left window" },
        j = { "<C-w>j", "Move to lower window" },
        k = { "<C-w>k", "Move to upper window" },
        l = { "<C-w>l", "Move to right window" },
        q = { nil, "Exit window mode" },
      }

      wk.show({ prefix = "", mode = "n", auto = false })
    end

    wk.add({
      { "<leader>wv", desc = "Split vertically" },
      { "<leader>ws", desc = "Split horizontally" },
      { "<leader>w=", desc = "Equal window width" },
      { "<leader>w+", desc = "Increase window height" },
      { "<leader>w-", desc = "Decrease window height" },
      { "<leader>w>", desc = "Increase window width" },
      { "<leader>w<", desc = "Decrease window width" },
      { "<leader>ww", window_hydra,                   desc = "Window hydra mode" },
    })

    -- Code operations submenu with description
    wk.add({
      { "<leader>c",  group = "Code Operations",      desc = "Operations for code editing and navigation" },
      { "<leader>ca", desc = "Code actions" },
      { "<leader>cf", desc = "Format code" },
      { "<leader>cr", desc = "Rename symbol" },
      { "<leader>ci", desc = "Code info/hover" },
      { "K",          desc = "Show hover information" },
      { "<leader>cR", desc = "Rename file" },
    })

    -- Go-to operations submenu with description
    wk.add({
      { "<leader>g",  group = "Go-to Operations", desc = "Operations for navigation and Git" },
      { "<leader>gd", desc = "Go to definition" },
      { "<leader>gr", desc = "Go to references" },
    })

    -- Diagnostics submenu with description
    wk.add({
      { "<leader>x", group = "Diagnostics/Utilities", desc = "Diagnostic tools and utilities" },
      { "[d",        desc = "Previous diagnostic" },
      { "]d",        desc = "Next diagnostic" },
      { "<leader>e", desc = "Show diagnostic message" },
      { "<leader>q", desc = "Open diagnostic list" },
    })

    -- Search operations submenu with description
    wk.add({
      { "<leader>s",  group = "Search Operations",      desc = "Operations for searching content" },
      { "<leader>sr", desc = "Search and replace" },
      { "<leader>ss", desc = "Search symbols" },
      { "<leader>st", desc = "Search TODOs" },
      { "<leader>sT", desc = "Search TODO/FIX/FIXME" },
      { "<leader>sw", desc = "Search word under cursor" },
      { "<leader>sn", desc = "Search notifications" },
    })

    -- Trouble diagnostics submenu with description
    wk.add({
      { "<leader>x",  group = "Trouble/Diagnostics",    desc = "Trouble and diagnostic operations" },
      { "<leader>xx", desc = "Toggle Trouble" },
      { "<leader>xw", desc = "Workspace diagnostics" },
      { "<leader>xd", desc = "Document diagnostics" },
      { "<leader>xq", desc = "Quickfix list" },
      { "<leader>xl", desc = "Location list" },
      { "gR",         desc = "LSP references" },
      { "<leader>xt", desc = "Todo (Trouble)" },
      { "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>xu", desc = "Undo Tree" },
      { "<leader>xb", desc = "Nav Buddy" },
    })

    -- Git operations submenu with description
    wk.add({
      { "<leader>g",  group = "Git Operations",    desc = "Operations for Git integration" },
      { "<leader>gb", desc = "Git blame line" },
      { "<leader>gB", desc = "Git browse",         mode = { "n", "v" } },
      { "<leader>gh", desc = "Git file history" },
      { "<leader>gg", desc = "Lazygit" },
      { "<leader>gl", desc = "Git log" },
      { "<leader>gc", desc = "Git commits" },
      { "<leader>gf", desc = "Git buffer commits" },
      { "<leader>gi", desc = "Advanced Git search" },
    })

    -- Toggle/UI operations submenu with description
    wk.add({
      { "<leader>t",  group = "Toggle Operations",   desc = "Various toggle operations" },
      { "<leader>tt", desc = "Toggle terminal" },
      { "<c-/>",      desc = "Toggle terminal" },
      { "<c-_>",      desc = "which_key_ignore" },
      { "<leader>z",  desc = "Toggle Zen Mode" },
      { "<leader>Z",  desc = "Toggle Zoom" },
      { "<leader>.",  desc = "Toggle Scratch Buffer" },
      { "<leader>S",  desc = "Select Scratch Buffer" },
      { "<leader>n",  desc = "Notification History" },
      { "<leader>N",  desc = "Neovim News" },
    })

    -- UI toggles submenu with description
    wk.add({
      { "<leader>u",  group = "UI Toggles",            desc = "Toggle UI elements and features" },
      { "<leader>us", desc = "Toggle spelling" },
      { "<leader>uw", desc = "Toggle word wrap" },
      { "<leader>uL", desc = "Toggle relative numbers" },
      { "<leader>ud", desc = "Toggle diagnostics" },
      { "<leader>ul", desc = "Toggle line numbers" },
      { "<leader>uc", desc = "Toggle conceal" },
      { "<leader>uT", desc = "Toggle treesitter" },
      { "<leader>ub", desc = "Toggle background" },
      { "<leader>uh", desc = "Toggle inlay hints" },
      { "<leader>ug", desc = "Toggle indent guides" },
      { "<leader>uD", desc = "Toggle dim mode" },
      { "<leader>uC", desc = "Color picker" },
      { "<leader>un", desc = "Dismiss Notifications" },
    })

    -- Avante AI (Claude) Integration
    wk.add({
      { "<leader>a",  group = "AI Assistant",  desc = "Claude AI Assistant operations" },
      { "<leader>aa", desc = "New Avante chat" },
      { "<leader>ac", desc = "Avante Clear" },
      { "<leader>af", desc = "Avante Focus" },
      { "<leader>at", desc = "Toggle Avante" },
      { "<leader>am", desc = "Avante Models" },
    })

    -- Visual mode AI Assistant mappings
    wk.add({
      { "<leader>a",  group = "AI Selection",                 desc = "AI operations on selection", mode = "v" },
      { "<leader>as", desc = "Ask Avante about selection",    mode = "v" },
      { "<leader>ai", desc = "Improve selection with Avante", mode = "v" },
      { "<leader>ae", desc = "Explain selection with Avante", mode = "v" },
    })

    -- Navigation aids
    wk.add({
      { "<C-n>", desc = "File Explorer" },
    })

    -- Todo comment navigation
    wk.add({
      { "]t", desc = "Next todo comment" },
      { "[t", desc = "Previous todo comment" },
    })

    -- Treesitter textobjects
    wk.add({
      { "<leader>p",  group = "Parameter Operations",       desc = "Operations for function parameters" },
      { "<leader>pi", desc = "Swap with next parameter" },
      { "<leader>ps", desc = "Swap with previous parameter" },
    })

    -- Miscellaneous utilities
    wk.add({
      { "<leader>m",  group = "Miscellaneous",     desc = "Miscellaneous utilities" },
      { "<leader>mp", desc = "Format with conform" },
      { "<leader>xd", desc = "Insert Date" },
      { "<leader>lu", desc = "Lazy Update (Sync)" },
    })

    -- Add a special mapping to show buffer-local keymaps
    wk.add({
      { "<leader>?", function() wk.show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" }
    })
  end,
}
