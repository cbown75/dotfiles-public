return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- Flash labels appear on your search target
    labels = "abcdefghijklmnopqrstuvwxyz",
    -- Show search prompt
    search = {
      -- Set the default forward search to case insensitive
      mode = function(str)
        return { search = str, forward = true, wrap = true, mode = "ignore-case" }
      end,
    },
    -- These are the default jump modes for Flash
    jump = {
      -- Register with jump functionality
      register = true, -- Set to false to disable setting the register
      -- When jumping to a match, execute normal mode command on the match
      -- Example: `d3j` to delete from cursor to the match
      autojump = false, -- Set to true to enable autojump by default
      -- Requires treesitter to work properly
      treesitter = {
        labels = true, -- Enable treesitter labels
        nodes = {
          ["parameter"] = { flash = true },
          ["class"] = { flash = true },
          ["function"] = { flash = true },
          ["method"] = { flash = true },
          ["for_statement"] = { flash = true },
          ["if_statement"] = { flash = true },
          ["while_statement"] = { flash = true },
          ["return_statement"] = { flash = true },
        },
      },
    },
    -- Options for different modes
    modes = {
      -- Options used when flash is activated through
      -- a regular search with `/` or `?`
      search = {
        enabled = true,               -- Enable Flash for search
        highlight = { backdrop = false }, -- Don't dim the background
        jump = { history = true },    -- Jump to the search results
        search = {
          -- If autojump is enabled, the first match will be automatically jumped to, but
          -- it will not increment the search history (:hnext)
          autojump = false,
          -- When `incremental` is true, the search will be incremental (jump to the first
          -- match as you type). If `autojump` is also true, the search will also jump
          -- to the first match as you type.
          incremental = true,
        },
      },
      -- Options used for treesitter selections
      -- `require("flash").treesitter()`
      treesitter = {
        labels = { "a", "s", "d", "f", "j", "k", "l", "h" }, -- Use homerow keys for closest matches
        jump = { pos = "range" },                        -- Jump to the range of the treesitter node
      },
      -- Options used for remote flash
      remote = {
        remote_op = { restore = true, motion = true },
      },
    },
    prompt = {
      enabled = true,
      prefix = { { "⚡", "FlashPromptIcon" } }, -- Use a lightning icon as the prefix
      win_config = {
        relative = "editor",
        width = 40, -- Prompt width
        height = 1,
        row = -1, -- Show at the bottom
        col = 0,
        zindex = 1000,
      },
    },
    -- Style customizations
    highlight = {
      -- Dim the background when flashing
      backdrop = true,
      -- Highlight matching labels
      matches = true,
      -- Groups for the different highlight states
      groups = {
        match = "FlashMatch",   -- Regular matches
        current = "FlashCurrent", -- Current match
        backdrop = "FlashBackdrop", -- Dim the background
        label = "FlashLabel",   -- Labels
      },
    },
  },
}
