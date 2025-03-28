local km = vim.keymap

-- Kubernetes Context Switching and Operations
km.set("n", "<leader>kc", function()
  local handle = io.popen("kubectl config get-contexts -o name")
  if not handle then
    vim.notify("Failed to get Kubernetes contexts", vim.log.levels.ERROR)
    return
  end

  local contexts = {}
  for context in handle:lines() do
    table.insert(contexts, context)
  end
  handle:close()

  vim.ui.select(contexts, {
    prompt = "Select Kubernetes Context:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      local cmd = "kubectl config use-context " .. choice
      local result = vim.fn.system(cmd)
      vim.notify("Switched to context: " .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = "Switch Kubernetes context" })

-- Get k8s resources
km.set("n", "<leader>kp", ":term kubectl get pods<CR>", { desc = "Get pods" })
km.set("n", "<leader>kd", ":term kubectl get deployments<CR>", { desc = "Get deployments" })
km.set("n", "<leader>ks", ":term kubectl get services<CR>", { desc = "Get services" })
km.set("n", "<leader>kn", ":term kubectl get nodes<CR>", { desc = "Get nodes" })

-- Kubectl logs and describe
km.set("n", "<leader>kl", function()
  -- Get list of pods
  local handle = io.popen("kubectl get pods -o name")
  if not handle then
    vim.notify("Failed to get pods", vim.log.levels.ERROR)
    return
  end

  local pods = {}
  for pod in handle:lines() do
    -- Strip "pod/" prefix
    pod = pod:gsub("^pod/", "")
    table.insert(pods, pod)
  end
  handle:close()

  vim.ui.select(pods, {
    prompt = "Select Pod to View Logs:",
  }, function(choice)
    if choice then
      vim.cmd("term kubectl logs " .. choice)
    end
  end)
end, { desc = "View pod logs" })

-- Terraform Operations
km.set("n", "<leader>tf", ":terminal terraform fmt<CR>", { desc = "Terraform format" })
km.set("n", "<leader>tp", ":terminal terraform plan<CR>", { desc = "Terraform plan" })
km.set("n", "<leader>ta", ":terminal terraform apply<CR>", { desc = "Terraform apply" })
km.set("n", "<leader>td", ":terminal terraform destroy<CR>", { desc = "Terraform destroy" })
km.set("n", "<leader>ti", ":terminal terraform init<CR>", { desc = "Terraform init" })
km.set("n", "<leader>tv", ":terminal terraform validate<CR>", { desc = "Terraform validate" })

-- AWS Operations
km.set("n", "<leader>ac", function()
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

-- Git operations extended for DevOps
km.set("n", "<leader>gpp", ":terminal git pull<CR>", { desc = "Git pull" })
km.set("n", "<leader>gps", ":terminal git push<CR>", { desc = "Git push" })
km.set("n", "<leader>gst", ":terminal git status<CR>", { desc = "Git status" })

-- Project navigation for common DevOps structures
km.set("n", "<leader>ct", function()
  -- Navigate to Terraform directory
  local terraform_dirs = { "./terraform", "../terraform", "./infra", "../infra" }
  for _, dir in ipairs(terraform_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd("cd " .. dir)
      vim.notify("Changed to " .. dir, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No Terraform directory found", vim.log.levels.WARN)
end, { desc = "Change to Terraform directory" })

km.set("n", "<leader>ck", function()
  -- Navigate to Kubernetes directory
  local k8s_dirs = { "./k8s", "../k8s", "./kubernetes", "../kubernetes", "./helm", "../helm" }
  for _, dir in ipairs(k8s_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd("cd " .. dir)
      vim.notify("Changed to " .. dir, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No Kubernetes directory found", vim.log.levels.WARN)
end, { desc = "Change to Kubernetes directory" })

-- YAML/JSON conversion
km.set("n", "<leader>yj", ":%!yq eval -j .<CR>", { desc = "Convert YAML to JSON" })
km.set("n", "<leader>jy", ":%!yq eval -y .<CR>", { desc = "Convert JSON to YAML" })

-- Base64 encode/decode selected text
km.set("v", "<leader>be", "c<C-r>=system('base64', @\")<CR><ESC>", { desc = "Base64 encode" })
km.set("v", "<leader>bd", "c<C-r>=system('base64 --decode', @\")<CR><ESC>", { desc = "Base64 decode" })

-- URL encode/decode selected text
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

-- Python virtual environment activation
km.set("n", "<leader>pyv", function()
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

-- Run common DevOps validation commands
km.set("n", "<leader>vt", ":term tflint<CR>", { desc = "Validate Terraform with tflint" })
km.set("n", "<leader>vk", ":term kubectl validate<CR>", { desc = "Validate Kubernetes manifests" })
km.set("n", "<leader>vy", ":term yamllint %<CR>", { desc = "Validate YAML with yamllint" })
km.set("n", "<leader>vd", ":term hadolint %<CR>", { desc = "Validate Dockerfile with hadolint" })

-- Add these to your keymaps.lua with:
-- require("config.keymaps-devops")
