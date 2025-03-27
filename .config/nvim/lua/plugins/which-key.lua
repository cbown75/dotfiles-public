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
      spacing = 3,       -- spacing between columns
    },
    -- Key behavior
    keys = {
      scroll_down = "<c-d>", -- scroll down in the popup
      scroll_up = "<c-u>", -- scroll up in the popup
    },
    -- Plugins configuration
    plugins = {
      marks = true,   -- shows marks on ' and `
      registers = true, -- shows registers on " in NORMAL or <C-r> in INSERT
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z=
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true,  -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true,  -- default bindings on <c-w>
        nav = true,      -- misc bindings to work with windows
        z = true,        -- bindings for folds, spelling and others prefixed with z
        g = true,        -- bindings for prefixed with g
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

    -- Add keymappings
    wk.add({
      -- Main groups
      { "<leader>a", group = "󱠁 AI Assistant" },
      { "<leader>b", group = "󰓩 Buffer" },
      { "<leader>c", group = "󰅱 Code" },
      { "<leader>d", group = "󰃤 Debug" },
      { "<leader>f", group = "󰈔 File/Find" },
      { "<leader>g", group = "󰊢 Git/Go-to" },
      { "<leader>l", group = "󰒲 Lazy" },
      { "<leader>m", group = "󰍘 Misc" },
      { "<leader>p", group = "󰏗 Project" },
      { "<leader>s", group = "󱘧 Search" },
      { "<leader>t", group = "󰍉 Tab/Terminal" },
      { "<leader>u", group = "󰒓 UI Toggle" },
      { "<leader>w", group = "󱂬 Window" },
      { "<leader>x", group = "󰁨 Diagnostics/Utilities" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
      { "g", group = "Go to" },

      -- AI Assistant mappings
      { "<leader>aa", desc = "New Avante chat" },
      { "<leader>at", desc = "Toggle Avante" },
      { "<leader>ac", desc = "Avante Clear" },
      { "<leader>af", desc = "Avante Focus" },
      { "<leader>am", desc = "Avante Models" },

      -- Visual mode AI Assistant mappings
      { "<leader>as", desc = "Ask Avante about selection", mode = "v" },
      { "<leader>ai", desc = "Improve selection with Avante", mode = "v" },
      { "<leader>ae", desc = "Explain selection with Avante", mode = "v" },

      -- Buffer mappings
      { "<leader>bf", desc = "Buffer list" },
      { "<leader>bn", desc = "Next buffer" },
      { "<leader>bp", desc = "Previous buffer" },
      { "<leader>bd", desc = "Delete buffer" },
      { "<leader>fb", desc = "Find open buffers" },

      -- Code mappings
      { "<leader>ca", desc = "Code actions" },
      { "<leader>cf", desc = "Format code" },
      { "<leader>cr", desc = "Rename symbol" },
      { "<leader>ci", desc = "Code info/hover" },
      { "<leader>cR", desc = "Rename file" },

      -- Debug mappings
      { "<leader>dB", desc = "Breakpoint condition" },
      { "<leader>db", desc = "Toggle breakpoint" },
      { "<leader>dc", desc = "Continue" },
      { "<leader>da", desc = "Run with arguments" },
      { "<leader>dC", desc = "Run to cursor" },
      { "<leader>dg", desc = "Go to line (no execute)" },
      { "<leader>di", desc = "Step into" },
      { "<leader>dj", desc = "Down" },
      { "<leader>dk", desc = "Up" },
      { "<leader>dl", desc = "Run last" },
      { "<leader>do", desc = "Step out" },
      { "<leader>dO", desc = "Step over" },
      { "<leader>dP", desc = "Pause" },
      { "<leader>dr", desc = "Toggle REPL" },
      { "<leader>ds", desc = "Session" },
      { "<leader>dt", desc = "Terminate" },
      { "<leader>du", desc = "Toggle UI" },
      { "<leader>dw", desc = "Widgets" },
      { "<leader>de", desc = "Evaluate", mode = { "n", "v" } },

      -- File/Find mappings
      { "<leader>ff", desc = "Find files" },
      { "<leader>fg", desc = "Find text" },
      { "<leader>fc", desc = "Find in code (no tests)" },
      { "<leader>fr", desc = "Recent files" },
      { "<leader>fs", desc = "Save file" },
      { "<leader>fw", desc = "Save all files" },
      { "<leader>fk", desc = "Find keymaps" },

      -- Go-to mappings
      { "<leader>gd", desc = "Go to definition" },
      { "<leader>gr", desc = "Go to references" },

      -- Git mappings
      { "<leader>gb", desc = "Git blame line" },
      { "<leader>gB", desc = "Git browse" },
      { "<leader>gh", desc = "Git file history" },
      { "<leader>gg", desc = "Lazygit" },
      { "<leader>gl", desc = "Git log" },
      { "<leader>gc", desc = "Git commits" },
      { "<leader>gf", desc = "Git buffer commits" },
      { "<leader>gi", desc = "Advanced Git search" },

      -- Diagnostics mappings
      { "[d", desc = "Previous diagnostic" },
      { "]d", desc = "Next diagnostic" },
      { "<leader>e", desc = "Show diagnostic message" },
      { "<leader>q", desc = "Open diagnostic list" },

      -- Search mappings
      { "<leader>sr", desc = "Search and replace" },
      { "<leader>ss", desc = "Search symbols" },
      { "<leader>st", desc = "Search TODOs" },
      { "<leader>sT", desc = "Search TODO/FIX/FIXME" },
      { "<leader>sw", desc = "Search word under cursor" },
      { "<leader>sn", desc = "Search notifications" },

      -- Trouble mappings
      { "<leader>xx", desc = "Toggle Trouble" },
      { "<leader>xw", desc = "Workspace diagnostics" },
      { "<leader>xd", desc = "Document diagnostics" },
      { "<leader>xq", desc = "Quickfix list" },
      { "<leader>xl", desc = "Location list" },
      { "gR", desc = "LSP references" },
      { "<leader>xt", desc = "Todo (Trouble)" },
      { "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)" },

      -- Tab mappings
      { "<leader>to", desc = "Open new tab" },
      { "<leader>tx", desc = "Close current tab" },
      { "<leader>tn", desc = "Go to next tab" },
      { "<leader>tp", desc = "Go to previous tab" },
      { "<leader>tf", desc = "Open current buffer in new tab" },

      -- Terminal/toggle mappings
      { "<leader>tt", desc = "Toggle terminal" },
      { "<leader>tu", desc = "Undo history" },
      { "<leader>z", desc = "Toggle Zen Mode" },
      { "<leader>Z", desc = "Toggle Zoom" },
      { "<leader>.", desc = "Toggle Scratch Buffer" },
      { "<leader>S", desc = "Select Scratch Buffer" },
      { "<leader>n", desc = "Notification History" },
      { "<leader>N", desc = "Neovim News" },

      -- UI toggle mappings
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

      -- Window mappings
      { "<leader>wv", desc = "Split vertically" },
      { "<leader>ws", desc = "Split horizontally" },
      { "<leader>w=", desc = "Equal window width" },
      { "<leader>w+", desc = "Increase window height" },
      { "<leader>w-", desc = "Decrease window height" },
      { "<leader>w>", desc = "Increase window width" },
      { "<leader>w<", desc = "Decrease window width" },

      -- Navigation aids
      { "<leader>xu", desc = "Undo Tree" },
      { "<leader>xb", desc = "Nav Buddy" },

      -- Todo comments navigation
      { "]t", desc = "Next todo comment" },
      { "[t", desc = "Previous todo comment" },

      -- Miscellaneous
      { "<leader>mp", desc = "Format with conform" },
      { "<leader>lu", desc = "Lazy Update (Sync)" },
      { "<leader>/", desc = "Fuzzily search in current buffer" },
    })

    -- Add an additional mapping to show buffer-local keymaps
    wk.add({
      {
        "<leader>?",
        function()
          wk.show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    })
  end,
}
