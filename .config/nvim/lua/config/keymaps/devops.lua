local km = vim.keymap

km.set("n", "<leader>tf", ":! terraform fmt<CR>", { desc = "Terraform Format" })
km.set("n", "<leader>tp", ":terminal terraform plan<CR>", { desc = "Terraform Plan" })
km.set("n", "<leader>ta", ":terminal terraform apply<CR>", { desc = "Terraform Apply" })
km.set("n", "<leader>td", ":terminal terraform destroy<CR>", { desc = "Terraform Destroy" })
km.set("n", "<leader>ti", ":terminal terraform init<CR>", { desc = "Terraform Init" })
km.set("n", "<leader>tv", ":terminal terraform validate<CR>", { desc = "Terraform Validate" })

km.set("n", "<leader>awp", function()
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

km.set("n", "<leader>awe", ":terminal aws ec2 describe-instances<CR>", { desc = "List EC2 instances" })
km.set("n", "<leader>aws", ":terminal aws s3 ls<CR>", { desc = "List S3 buckets" })
km.set("n", "<leader>awl", ":terminal aws lambda list-functions<CR>", { desc = "List Lambda functions" })
km.set("n", "<leader>awr", ":terminal aws rds describe-db-instances<CR>", { desc = "List RDS instances" })

km.set("n", "<leader>doc", ":terminal docker-compose up -d<CR>", { desc = "Docker-compose up" })
km.set("n", "<leader>dod", ":terminal docker-compose down<CR>", { desc = "Docker-compose down" })
km.set("n", "<leader>dol", ":terminal docker ps<CR>", { desc = "List Docker containers" })
km.set("n", "<leader>doi", ":terminal docker images<CR>", { desc = "List Docker images" })
km.set("n", "<leader>dop", ":terminal docker pull<Space>", { desc = "Docker pull" })
km.set("n", "<leader>dob", ":terminal docker build -t<Space>", { desc = "Docker build" })

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

km.set("n", "<leader>vd", ":term hadolint %<CR>", { desc = "Validate Dockerfile with hadolint" })

km.set("n", "<leader>yj", ":%!yq eval -j .<CR>", { desc = "Convert YAML to JSON" })
km.set("n", "<leader>jy", ":%!yq eval -y .<CR>", { desc = "Convert JSON to YAML" })

km.set("v", "<leader>be", "c<C-r>=system('base64', @\")<CR><ESC>", { desc = "Base64 encode" })
km.set("v", "<leader>bd", "c<C-r>=system('base64 --decode', @\")<CR><ESC>", { desc = "Base64 decode" })

km.set(
  "v",
  "<leader>ure",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL encode" }
)
km.set(
  "v",
  "<leader>urd",
  'c<C-r>=system(\'python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.stdin.read()))"\', @")<CR><ESC>',
  { desc = "URL decode" }
)

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

-- Navigate to a project directory
km.set("n", "<leader>ct", function()
  -- Navigate to Terraform directory
  local tf_dirs = { "./terraform", "../terraform", "./infra", "../infra" }
  for _, dir in ipairs(tf_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd("cd " .. dir)
      vim.notify("Changed to " .. dir, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No Terraform directory found", vim.log.levels.WARN)
end, { desc = "Change to Terraform directory" })

return {}
