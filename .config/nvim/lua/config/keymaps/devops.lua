local km = vim.keymap

-- AWS Operations
km.set("n", "<leader>ap", function()
  local aws_config_file = os.getenv("HOME") .. "/.aws/config"
  local profiles = {}

  local file = io.open(aws_config_file, "r")
  if not file then
    vim.notify("AWS config file not found", vim.log.levels.ERROR)
    return
  end

  for line in file:lines() do
    local profile = line:match("^%[profile%s+(.+)%]$")
    if profile then
      table.insert(profiles, profile)
    end
  end
  file:close()

  vim.ui.select(profiles, {
    prompt = "Select AWS Profile:",
  }, function(choice)
    if choice then
      vim.env.AWS_PROFILE = choice
      vim.notify("AWS profile set to: " .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = "Switch AWS profile" })

-- AWS resource listing
km.set("n", "<leader>ae", ":terminal aws ec2 describe-instances<CR>", { desc = "List EC2 instances" })
km.set("n", "<leader>as", ":terminal aws s3 ls<CR>", { desc = "List S3 buckets" })
km.set("n", "<leader>al", ":terminal aws lambda list-functions<CR>", { desc = "List Lambda functions" })
km.set("n", "<leader>ar", ":terminal aws rds describe-db-instances<CR>", { desc = "List RDS instances" })

-- Docker operations
km.set("n", "<leader>dc", ":terminal docker-compose up -d<CR>", { desc = "Docker-compose up" })
km.set("n", "<leader>dd", ":terminal docker-compose down<CR>", { desc = "Docker-compose down" })
km.set("n", "<leader>dl", ":terminal docker ps<CR>", { desc = "List Docker containers" })
km.set("n", "<leader>di", ":terminal docker images<CR>", { desc = "List Docker images" })
km.set("n", "<leader>dp", ":terminal docker pull<Space>", { desc = "Docker pull" })
km.set("n", "<leader>db", ":terminal docker build -t<Space>", { desc = "Docker build" })

-- Python virtual environment activation
km.set("n", "<leader>py", function()
  -- Try to find virtual environments in common locations
  local venv_dirs = {
    vim.fn.getcwd() .. "/venv",
    vim.fn.getcwd() .. "/.venv",
    vim.fn.expand("~/.virtualenvs"),
  }

  local venvs = {}
  for _, dir in ipairs(venv_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      if vim.fn.isdirectory(dir .. "/bin") == 1 then
        -- This is a single venv
        table.insert(venvs, dir)
      else
        -- This might be a directory containing multiple venvs
        local handle = io.popen("ls -1 " .. dir)
        if handle then
          for venv in handle:lines() do
            if vim.fn.isdirectory(dir .. "/" .. venv .. "/bin") == 1 then
              table.insert(venvs, dir .. "/" .. venv)
            end
          end
          handle:close()
        end
      end
    end
  end

  vim.ui.select(venvs, {
    prompt = "Select Python Virtual Environment:",
  }, function(choice)
    if choice then
      vim.env.VIRTUAL_ENV = choice
      -- Update PATH to include the venv's bin directory
      local venv_bin = choice .. "/bin"
      vim.env.PATH = venv_bin .. ":" .. vim.env.PATH
      vim.notify("Activated virtual environment: " .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = "Activate Python virtual environment" })

-- Docker validation
km.set("n", "<leader>vd", ":term hadolint %<CR>", { desc = "Validate Dockerfile with hadolint" })

-- YAML/JSON conversion
km.set("n", "<leader>yj", ":%!yq eval -j .<CR>", { desc = "Convert YAML to JSON" })
km.set("n", "<leader>jy", ":%!yq eval -y .<CR>", { desc = "Convert JSON to YAML" })

-- Base64 encode/decode selected text
km.set("v", "<leader>be", "c<C-r>=system('base64', @\")<CR><ESC>", { desc = "Base64 encode" })
km.set("v", "<leader>bd", "c<C-r>=system('base64 --decode', @\")<CR><ESC>", { desc = "Base64 decode" })

-- URL encode/decode selected text
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

-- SSH to selected host
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

return {}
