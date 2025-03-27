local mode_map = {
  ["NORMAL"] = "N",
  ["O-PENDING"] = "N?",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  ["REPLACE"] = "R",
  ["COMMAND"] = "!",
  ["SHELL"] = "SH",
  ["TERMINAL"] = "T",
  ["EX"] = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  ["SELECT"] = "S",
  ["CONFIRM"] = "Y?",
  ["MORE"] = "M",
}

-- Dracula color palette
local colors = {
  bg = "#282A36",
  fg = "#F8F8F2",
  selection = "#44475A",
  comment = "#6272A4",
  red = "#FF5555",
  orange = "#FFB86C",
  yellow = "#F1FA8C",
  green = "#50FA7B",
  purple = "#BD93F9",
  cyan = "#8BE9FD",
  pink = "#FF79C6",
  bright_red = "#FF6E6E",
  bright_green = "#69FF94",
  bright_yellow = "#FFFFA5",
  bright_blue = "#D6ACFF",
  bright_magenta = "#FF92DF",
  bright_cyan = "#A4FFFF",
  bright_white = "#FFFFFF",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}

-- Mode colors using Dracula palette
local mode_colors = {
  n = colors.comment,           -- normal: blue/comment
  i = colors.cyan,              -- insert: cyan
  v = colors.orange,            -- visual: orange
  [''] = colors.orange,         -- visual block: orange
  V = colors.orange,            -- visual line: orange
  c = colors.purple,            -- command: purple
  no = colors.comment,          -- n-operator pending
  s = colors.bright_magenta,    -- select: magenta
  S = colors.bright_magenta,    -- select line
  [''] = colors.bright_magenta, -- select block
  ic = colors.cyan,             -- insert completion
  R = colors.red,               -- replace: red
  Rv = colors.red,              -- virtual replace
  cv = colors.purple,           -- command (vim ex)
  ce = colors.purple,           -- command edit
  r = colors.red,               -- prompt
  rm = colors.cyan,             -- more prompt
  ['r?'] = colors.pink,         -- confirm
  ['!'] = colors.green,         -- shell
  t = colors.green,             -- terminal
}

-- Performance optimization: Add a global scrolling detection
local is_scrolling = false
local scroll_timer = vim.loop.new_timer()

-- Caches for expensive operations
local git_cache = { value = "", last_check = 0 }
local project_cache = { value = "", last_check = 0 }
local lsp_cache = { value = "", last_check = 0 }

-- Get current mode color
local function mode_color()
  local mode = vim.api.nvim_get_mode().mode
  return mode_colors[mode] or "#F8F8F2" -- default color
end

-- Stolen/amended from https://github.com/leonasdev/.dotfiles/blob/master/.config/nvim/lua/util/statusline.lua
local function getScrollPos()
  local progressIcons = {
    "󰋙 ",
    "󰫃 ",
    "󰫄 ",
    "󰫅 ",
    "󰫆 ",
    "󰫇 ",
    "󰫈 ",
  }
  local current = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((current - 1) / lines * #progressIcons) + 1
  local sbar = string.format(progressIcons[i])

  local colPre = "c"
  local col = "%c "

  return string.format("%s%s%s", colPre, col, sbar)
end

-- Optimized createDiffString with caching
local function createDiffString()
  -- Only update every 2 seconds
  local now = vim.fn.localtime()
  if now - git_cache.last_check > 2 or git_cache.value == "" then
    local diffparts = vim.b.gitsigns_status_dict
    if not diffparts then
      git_cache.value = ""
      git_cache.last_check = now
      return ""
    end

    local head = diffparts.head or "unknown"
    local head_and_icon = "󰘬 " .. head
    local added = diffparts.added or 0
    local removed = diffparts.removed or 0
    local changed = diffparts.changed or 0

    -- Start constructing the output string
    local output = string.format("%%#lualine_b_normal#%s", head_and_icon)
    local hasChanges = false

    if added > 0 or removed > 0 or changed > 0 then
      output = output .. string.format("%%#lualine_b_normal#%s", "(")
      hasChanges = true
    end

    if added > 0 then
      output = output .. string.format("%%#lualine_b_diff_added_normal#+%d", added)
    end

    if removed > 0 then
      output = output .. string.format("%%#lualine_b_diff_removed_normal#-%d", removed)
    end

    if changed > 0 then
      output = output .. string.format("%%#lualine_b_diff_modified_normal#~%d", changed)
    end

    -- Close the parentheses if any changes were added
    if hasChanges then
      output = output .. string.format("%%#lualine_b_normal#%s", ")")
    end

    -- Update cache
    git_cache.value = output
    git_cache.last_check = now
  end

  -- Return from cache
  return git_cache.value
end

-- Make a global table
wordCount = {}
-- Now add a function to it for the job needed
function wordCount.getWords()
  if is_scrolling then return "" end
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return "Not a text file"
  end
end

-- LSP Status function to show current language server - with caching
local function lsp_status()
  if is_scrolling then return lsp_cache.value end

  local now = vim.fn.localtime()
  if now - lsp_cache.last_check > 5 or lsp_cache.value == "" then
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      lsp_cache.value = "No LSP"
      lsp_cache.last_check = now
      return lsp_cache.value
    end

    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end

    lsp_cache.value = "LSP: " .. table.concat(client_names, ", ")
    lsp_cache.last_check = now
  end

  return lsp_cache.value
end

-- Show current project with caching
local function get_project()
  if is_scrolling then return project_cache.value end

  local now = vim.fn.localtime()
  if now - project_cache.last_check > 30 or project_cache.value == "" then
    local cwd = vim.fn.getcwd()
    local home = os.getenv("HOME")
    local project = cwd

    -- Replace home with ~
    if home and cwd:find(home, 1, true) == 1 then
      project = "~" .. cwd:sub(#home + 1)
    end

    -- Extract just the project name (last directory in path)
    local project_name = project:match("([^/]+)$")

    project_cache.value = "󰙅 " .. (project_name or project)
    project_cache.last_check = now
  end

  return project_cache.value
end

-- Show file encoding and format
local file_info_cache = { value = "", last_update = 0, bufnr = -1 }
local function file_info()
  local current_bufnr = vim.api.nvim_get_current_buf()

  -- Only update if buffer changed or every 5 seconds
  local now = vim.fn.localtime()
  if current_bufnr ~= file_info_cache.bufnr or
      now - file_info_cache.last_update > 5 or
      file_info_cache.value == "" then
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    local format = vim.bo.fileformat
    local file_icon = "󰈚"

    if format == "unix" then
      format = "LF"
    elseif format == "dos" then
      format = "CRLF"
    elseif format == "mac" then
      format = "CR"
    end

    file_info_cache.value = file_icon .. " " .. enc:upper() .. " " .. format
    file_info_cache.last_update = now
    file_info_cache.bufnr = current_bufnr
  end

  return file_info_cache.value
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function window()
  return vim.api.nvim_win_get_number(0)
end

-- Show file size with caching
local file_size_cache = { value = "", last_update = 0, filename = "" }
local function file_size()
  local file = vim.fn.expand("%:p")
  if file == nil or file == "" then return "" end

  -- Only update if filename changed or every 5 seconds
  local now = vim.fn.localtime()
  if file ~= file_size_cache.filename or
      now - file_size_cache.last_update > 5 or
      file_size_cache.value == "" then
    local size = vim.fn.getfsize(file)
    if size <= 0 then
      file_size_cache.value = ""
      file_size_cache.last_update = now
      file_size_cache.filename = file
      return ""
    end

    local suffixes = { 'B', 'KB', 'MB', 'GB' }
    local i = 1
    while size > 1024 and i < #suffixes do
      size = size / 1024
      i = i + 1
    end

    file_size_cache.value = string.format("%.1f%s", size, suffixes[i])
    file_size_cache.last_update = now
    file_size_cache.filename = file
  end

  return file_size_cache.value
end

-- adapted from https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "󰑋  " .. recording_register
  end
end

-- Get filename with modified indicator
local filename_cache = { value = "", last_update = 0, bufnr = -1 }
local function filename()
  local current_bufnr = vim.api.nvim_get_current_buf()

  -- Only update if buffer changed or buffer was modified
  local buffer_modified = vim.bo.modified
  if current_bufnr ~= filename_cache.bufnr or
      buffer_modified or
      filename_cache.value == "" then
    local filename = vim.fn.expand("%:t")
    local readonly = vim.bo.readonly

    if filename == "" then
      filename = "[No Name]"
    end

    -- Add appropriate icon based on file state
    if readonly then
      filename_cache.value = " " .. filename
    elseif buffer_modified then
      filename_cache.value = "󰐖 " .. filename
    else
      filename_cache.value = filename
    end

    filename_cache.bufnr = current_bufnr
  end

  return filename_cache.value
end

-- Virtual environment for Python with caching
local python_env_cache = { value = "", last_update = 0 }
local function python_env()
  if vim.bo.filetype ~= "python" then return "" end

  -- Check every 30 seconds
  local now = vim.fn.localtime()
  if now - python_env_cache.last_update > 30 or python_env_cache.value == "" then
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
      -- Get just the venv name
      local venv_name = string.match(venv, "([^/]+)$")
      python_env_cache.value = "󰆧 " .. (venv_name or venv)
    else
      python_env_cache.value = ""
    end

    python_env_cache.last_update = now
  end

  return python_env_cache.value
end

-- CPU load function removed

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    globalstatus = true, -- Use a single statusline for all windows
    refresh = {
      statusline = 250,  -- Refresh rate for statusline in ms
      tabline = 1000,    -- Refresh rate for tabline in ms
      winbar = 1000      -- Refresh rate for winbar in ms
    }
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(s)
          return mode_map[s] or s
        end,
        color = function()
          return { bg = mode_color() }
        end,
      },
    },
    lualine_b = {
      {
        createDiffString,
        color = nil,
        cond = function()
          return true -- Now that it's cached, we can always run it
        end,
      },
      {
        get_project,
        cond = function()
          return vim.fn.winwidth(0) > 80
        end,
      },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" }, draw_empty = false },
      function()
        return "%="
      end,
      {
        filename,
        path = 0,
        shorting_target = 40,
      },
      {
        wordCount.getWords,
        color = { fg = colors.bg, bg = colors.green },
        separator = { left = "", right = "" },
        cond = function()
          return wordCount.getWords() ~= "Not a text file" and not is_scrolling
        end,
      },
      {
        "searchcount",
      },
      {
        "selectioncount",
      },
      {
        show_macro_recording,
        color = { fg = colors.bg, bg = colors.red },
        separator = { left = "", right = "" },
      },
      {
        lsp_status,
        cond = function()
          return #vim.lsp.get_clients({ bufnr = 0 }) > 0 or lsp_cache.value ~= ""
        end,
        icon = "󰄭",
      },
      {
        python_env,
        color = { fg = colors.green },
        cond = function()
          return not is_scrolling
        end,
      },
    },
    lualine_y = {
      {
        file_info,
        cond = function()
          return vim.fn.winwidth(0) > 80
        end,
      },
      {
        file_size,
        cond = function()
          return vim.fn.winwidth(0) > 80
        end,
      },
    },
    lualine_x = {
      { getScrollPos, width = 100, padding = { left = 10, right = 1 } },
    },
    lualine_z = {
      {
        "progress",
        color = function()
          return { bg = mode_color() }
        end,
      },
    },
  },
  inactive_sections = {
    lualine_a = { { window, color = { fg = colors.cyan, bg = colors.selection } } },
    lualine_b = {
      {
        "diff",
        source = diff_source,
        color_added = colors.green,
        color_modified = colors.yellow,
        color_removed = colors.red,
      },
    },
    lualine_c = {
      function()
        return "%="
      end,
      {
        "filename",
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = "󰐖 ", -- Text to show when the file is modified.
          readonly = " ", -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No Name]", -- Text to show for unnamed buffers.
          newfile = "[New]", -- Text to show for new created file before first writting
        },
      },
    },
    lualine_x = {
      { getScrollPos, padding = { left = 1, right = 1 } },
    },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
    "oil",
    "fzf",
    "trouble",
    "neo-tree",
  },
})

local lualine = require("lualine")

-- Set up autocmd to detect scrolling
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  callback = function()
    is_scrolling = true
    -- Reset scrolling state after 300ms of inactivity
    if scroll_timer then
      scroll_timer:stop()
      scroll_timer:start(300, 0, vim.schedule_wrap(function()
        is_scrolling = false
        lualine.refresh()
      end))
    end
  end
})

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    lualine.refresh()
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    -- This is going to seem really weird!
    -- Instead of just calling refresh we need to wait a moment because of the nature of
    -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
    -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
    -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
    -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        lualine.refresh()
      end)
    )
  end,
})
