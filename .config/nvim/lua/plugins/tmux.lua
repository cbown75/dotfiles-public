return {
  "aserowy/tmux.nvim", -- Change from "nathom/tmux.nvim" to "aserowy/tmux.nvim"
  config = function()
    require("tmux").setup({
      -- Better copy mode integration
      copy_sync = {
        -- Sync yanks from Neovim to tmux clipboard
        enable = true,
        -- Sync registers between Neovim instances
        sync_clipboard = true,
        sync_registers = true,
        -- Remove escape sequences automatically
        trim_last_nl = true,
      },
      -- Improve navigation between panes
      navigation = {
        -- Enable cycling through panes
        cycle_navigation = true,
        -- Enable navigation in copy-mode
        enable_default_keybindings = false,
        -- Prevents tmux from wrapping back to top when reaching end of screen
        persist_zoom = true,
      },
      -- Support tmux windows like Neovim tabs
      resize = {
        -- Enable resizing tmux panes from Neovim
        enable_default_keybindings = false,
        -- Resize amount for horizontal direction
        resize_step_x = 5,
        -- Resize amount for vertical direction
        resize_step_y = 5,
      },
    })
  end,
}
