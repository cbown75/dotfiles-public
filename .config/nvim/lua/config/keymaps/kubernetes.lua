-- ~/.config/nvim/lua/config/keymaps/kubernetes.lua
local km = vim.keymap

-- Kubernetes operations with main group prefix <leader>ok
km.set("n", "<leader>ok", "<nop>", { desc = "Kubernetes" })

-- Basic k9s operations
km.set("n", "<leader>ok9", ":K9s<CR>", { desc = "Launch k9s" })
km.set("n", "<leader>okv", ":K9s vctx<CR>", { desc = "Launch k9s in vertical split" })
km.set("n", "<leader>okh", ":K9s ctx<CR>", { desc = "Launch k9s in horizontal split" })

-- Context and namespace management
km.set("n", "<leader>okc", ":K9s context<CR>", { desc = "Change Kubernetes context" })
km.set("n", "<leader>okn", ":K9s namespace<CR>", { desc = "Change Kubernetes namespace" })

-- Resource viewing
km.set("n", "<leader>okp", ":K9s pods<CR>", { desc = "View pods in k9s" })
km.set("n", "<leader>okd", ":K9s deployments<CR>", { desc = "View deployments in k9s" })
km.set("n", "<leader>oks", ":K9s services<CR>", { desc = "View services in k9s" })
km.set("n", "<leader>oki", ":K9s ingresses<CR>", { desc = "View ingresses in k9s" })
km.set("n", "<leader>okm", ":K9s configmaps<CR>", { desc = "View configmaps in k9s" })
km.set("n", "<leader>okS", ":K9s secrets<CR>", { desc = "View secrets in k9s" })
km.set("n", "<leader>okj", ":K9s jobs<CR>", { desc = "View jobs in k9s" })
km.set("n", "<leader>okr", ":K9s file<CR>", { desc = "View resource from current file" })

-- Logs viewing
km.set("n", "<leader>okl", ":K9sLogs<CR>", { desc = "View logs for resource" })
km.set("n", "<leader>okL", function()
  -- Extract pod name from current file and view logs
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, "\n")

  local kind = content:match("kind:%s*([%w-]+)")
  local name = content:match("name:%s*([%w-]+)")

  if kind and name then
    local resource_type = kind:lower()

    -- Map to kubectl abbreviations
    local resource_map = {
      deployment = "deploy",
      statefulset = "sts",
      daemonset = "ds",
      service = "svc",
      ingress = "ing",
      configmap = "cm",
    }

    resource_type = resource_map[resource_type] or resource_type

    vim.cmd("K9sLogs " .. resource_type .. "/" .. name)
  else
    vim.notify("Could not detect kubernetes resource in file", vim.log.levels.WARN)
    vim.cmd("K9sLogs")
  end
end, { desc = "View logs for resource in current file" })

-- Apply current file
km.set("n", "<leader>oka", function()
  -- Get the file path
  local filepath = vim.fn.expand("%:p")

  -- Check if file exists and is yaml/json
  local filetype = vim.bo.filetype
  if filetype ~= "yaml" and filetype ~= "json" then
    vim.notify("Current file is not YAML or JSON", vim.log.levels.WARN)
    return
  end

  -- Ask for confirmation
  vim.ui.select({ "Yes", "No" }, {
    prompt = "Apply " .. vim.fn.expand("%:t") .. "?",
  }, function(choice)
    if choice == "Yes" then
      -- Use dry-run first
      local cmd_dryrun = string.format("kubectl apply --dry-run=client -f %s", filepath)

      local handle = io.popen(cmd_dryrun .. " 2>&1")
      if not handle then
        vim.notify("Failed to execute kubectl apply dry-run", vim.log.levels.ERROR)
        return
      end

      local result = handle:read("*a")
      handle:close()

      -- Check if dry-run succeeded
      if result:find("Error") or result:find("error") then
        vim.notify("Dry-run failed: " .. result, vim.log.levels.ERROR)
        return
      end

      -- Now do the actual apply
      local cmd = string.format("kubectl apply -f %s", filepath)

      handle = io.popen(cmd .. " 2>&1")
      if not handle then
        vim.notify("Failed to execute kubectl apply", vim.log.levels.ERROR)
        return
      end

      result = handle:read("*a")
      handle:close()

      -- Notify about the result
      if result:find("Error") or result:find("error") then
        vim.notify("Apply failed: " .. result, vim.log.levels.ERROR)
      else
        vim.notify("Applied: " .. result, vim.log.levels.INFO)
      end
    end
  end)
end, { desc = "Apply current kubernetes manifest" })

-- Navigate to Kubernetes directory
km.set("n", "<leader>cok", function()
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

return {}
