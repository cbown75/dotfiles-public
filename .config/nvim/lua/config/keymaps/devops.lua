local km = vim.keymap

-- DevOps master group - using <leader>o as a new prefix (for "operations")
km.set("n", "<leader>o", "<nop>", { desc = "DevOps Tools" })

-- Data conversion commands - move to DevOps group
km.set("n", "<leader>oy", ":%!yq eval -j .<CR>", { desc = "Convert YAML to JSON" })
km.set("n", "<leader>oj", ":%!yq eval -y .<CR>", { desc = "Convert JSON to YAML" })

-- Encoding/decoding commands - moved to DevOps group
km.set("v", "<leader>oe", "c<C-r>=system('base64', @\")<CR><ESC>", { desc = "Base64 encode" })
km.set("v", "<leader>ob", "c<C-r>=system('base64 --decode', @\")<CR><ESC>", { desc = "Base64 decode" })
km.set(
  "v",
  "<leader>oue",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL encode" }
)
km.set(
  "v",
  "<leader>oud",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL decode" }
)

-- SSH shortcuts
km.set("n", "<leader>os", function()
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
km.set("n", "<leader>ov", "<nop>", { desc = "Validate" })
km.set("n", "<leader>ovy", ":term yamllint %<CR>", { desc = "Validate YAML with yamllint" })
km.set("n", "<leader>ovk", ":term kubectl validate<CR>", { desc = "Validate Kubernetes manifests" })
km.set("n", "<leader>ovt", ":term terraform validate<CR>", { desc = "Validate Terraform" })
km.set("n", "<leader>ovd", ":term hadolint %<CR>", { desc = "Validate Dockerfile" })

-- Project navigation keymaps
km.set("n", "<leader>co", "<nop>", { desc = "Change Dir (DevOps)" })

return {}
