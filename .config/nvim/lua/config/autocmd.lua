-- Group autocommands for better organization
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize splits on window resize",
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close some filetypes with just 'q'
vim.api.nvim_create_autocmd("FileType", {
  desc = "Close certain filetypes with q",
  group = augroup("close_with_q"),
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto format on save (if formatter is available)
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto format on save",
  group = augroup("auto_format"),
  callback = function()
    local filetype = vim.bo.filetype

    -- Check if formatters are available for this filetype
    if filetype == "lua" then
      -- Only format Lua if stylua is available
      if vim.fn.executable("stylua") == 1 then
        vim.cmd("silent! Conform")
      end
    elseif vim.fn.exists(":ConformInfo") > 0 then
      -- For other filetypes, check if Conform is available
      vim.cmd("silent! Conform")
    end
  end,
})

-- Set wrap and spell in markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell check for text files",
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Automatically reload the file if it changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if files changed outside of Neovim",
  group = augroup("checktime"),
  command = "checktime",
})

-- Handle scrolling performance
vim.api.nvim_create_autocmd("CursorMoved", {
  desc = "Optimize scrolling performance",
  group = augroup("scroll_performance"),
  callback = function()
    if not _G.scroll_state then
      _G.scroll_state = {
        is_scrolling = false,
        timer = vim.loop.new_timer(),
      }
    end

    _G.scroll_state.is_scrolling = true

    if _G.scroll_state.timer then
      _G.scroll_state.timer:stop()
    end

    _G.scroll_state.timer:start(
      300,
      0,
      vim.schedule_wrap(function()
        _G.scroll_state.is_scrolling = false
        vim.cmd("redrawstatus")
      end)
    )
  end,
})

-- Auto format on save (if formatter is available)
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto format on save",
  group = augroup("auto_format"),
  callback = function()
    -- Skip formatting if Conform isn't available
    if not package.loaded["conform"] then
      return
    end

    -- Use the API directly with quiet = true to suppress messages
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
      quiet = true, -- This suppresses the messages
    })
  end,
})

-- Remember and restore cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor position when opening a file",
  group = augroup("restore_cursor"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Enable relative numbers in normal mode, absolute in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  desc = "Disable relative numbers in insert mode",
  group = augroup("numbertoggle"),
  callback = function()
    if vim.wo.number and vim.wo.relativenumber then
      vim.cmd("set norelativenumber")
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  desc = "Restore relative numbers in normal mode",
  group = augroup("numbertoggle"),
  callback = function()
    if vim.wo.number and not vim.wo.relativenumber then
      vim.cmd("set relativenumber")
    end
  end,
})

-- Auto-detect indentation (tabs vs spaces)
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  desc = "Auto-detect indentation",
  group = augroup("auto_indent"),
  callback = function()
    -- Skip binary files and large files
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if not ok or stats.size > max_filesize then
      return
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, 100, false)
    local tabs, spaces = 0, 0

    for _, line in ipairs(lines) do
      if line:match("^\t") then
        tabs = tabs + 1
      elseif line:match("^ ") then
        spaces = spaces + 1
      end
    end

    if tabs > spaces then
      vim.bo.expandtab = false
    else
      vim.bo.expandtab = true
    end
  end,
})

-- Open help in a vertical split
vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help in vertical split",
  group = augroup("vertical_help"),
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Python snippet shortcuts",
  group = augroup("python_snippets"),
  pattern = "python",
  callback = function()
    -- Map ,p to print snippet
    vim.keymap.set("i", ",p", function()
      _G.luasnip_helpers.py_print()
    end, { buffer = true, silent = true })
  end,
})

-- Add this to your autocmd.lua file (completely rewritten for safety)
vim.api.nvim_create_user_command("SnippetEdit", function(opts)
  local ft = opts.args ~= "" and opts.args or vim.bo.filetype
  local snippet_file = vim.fn.expand("~/git/snippets/") .. ft .. "/init.lua"

  -- Create directory if it doesn't exist
  local dir = vim.fn.fnamemodify(snippet_file, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end

  -- Create file if it doesn't exist
  if vim.fn.filereadable(snippet_file) == 0 then
    -- Build template line by line to avoid nesting issues
    local template = {}
    table.insert(template, 'local ls = require("luasnip")')
    table.insert(template, "local s = ls.snippet")
    table.insert(template, "local t = ls.text_node")
    table.insert(template, "local i = ls.insert_node")
    table.insert(template, "local f = ls.function_node")
    table.insert(template, "local c = ls.choice_node")
    table.insert(template, 'local fmt = require("luasnip.extras.fmt").fmt')
    table.insert(template, "")
    table.insert(template, "return {")
    table.insert(template, "  -- Example snippet")
    table.insert(template, '  s("example", fmt([[')
    table.insert(template, "  This is an example {} snippet for " .. ft .. ".")
    table.insert(template, "  ]], {")
    table.insert(template, '    i(1, "custom"),')
    table.insert(template, "  })),")
    table.insert(template, "}")

    vim.fn.writefile(template, snippet_file)
  end

  -- Open the snippet file
  vim.cmd("edit " .. snippet_file)
end, { nargs = "?", desc = "Edit snippets for filetype" })

-- Better terminal handling in autocmd.lua
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Terminal settings",
  group = augroup("terminal_settings"),
  callback = function()
    -- Set options for terminal buffers
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    -- Start in insert mode
    vim.cmd("startinsert")
  end,
})

-- Automatically close terminal buffers when process exits
vim.api.nvim_create_autocmd("TermClose", {
  desc = "Auto close terminal buffers",
  group = augroup("terminal_close"),
  callback = function(args)
    -- Check if this is a terminal window
    local buftype = vim.bo[args.buf].buftype
    if buftype == "terminal" then
      -- Close if process exited successfully
      local job_status = vim.v.event.status
      if job_status == 0 then
        vim.cmd("bdelete! " .. args.buf)
      end
    end
  end,
})
