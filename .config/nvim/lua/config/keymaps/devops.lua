local km = vim.keymap

-- Data conversion commands
km.set("n", "<leader>yj", ":%!yq eval -j .<CR>", { desc = "Convert YAML to JSON" })
km.set("n", "<leader>jy", ":%!yq eval -y .<CR>", { desc = "Convert JSON to YAML" })

-- Encoding/decoding commands
km.set("v", "<leader>be", "c<C-r>=system('base64', @\")<CR><ESC>", { desc = "Base64 encode" })
km.set("v", "<leader>bd", "c<C-r>=system('base64 --decode', @\")<CR><ESC>", { desc = "Base64 decode" })
km.set(
  "v",
  "<leader>ue",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL encode" }
)
km.set(
  "v",
  "<leader>ud",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL decode" }
)

-- SSH shortcuts
km.set("n", "<leader>sh", function()
  -- Try to read hosts from SSH config
  local hosts = {}
  local ssh_config = os.getenv("HOME") .. "/.ssh/config"

  local file = io.open(ssh_config, "r")
  if file then
    for line in file:lines() do
      local host = line:match("^Host%s+([^*]+)$")
      if host and not host:match("%s") then
        table.insert(hosts, host)
      end
    end
    file:close()
  end

  vim.ui.select(hosts, {
    prompt = "Select SSH Host:",
  }, function(choice)
    if choice then
      vim.cmd("term ssh " .. choice)
    end
  end)
end, { desc = "SSH to host" })

-- General validation commands
km.set("n", "<leader>vy", ":term yamllint %<CR>", { desc = "Validate YAML with yamllint" })

return {}
