return {
  { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "nanotee/zoxide.vim" },
  { "debugloop/telescope-undo.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "mbbill/undotree",
    config = function() end,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
    },
  },
  {
    "exosyphon/telescope-color-picker.nvim",
    config = function() end,
  },
}
