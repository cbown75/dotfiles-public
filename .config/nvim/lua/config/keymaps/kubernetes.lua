local km = vim.keymap

-- Basic k9s operations
km.set("n", "<leader>k9", ":K9s<CR>", { desc = "Launch k9s" })
km.set("n", "<leader>kv", ":K9s vctx<CR>", { desc = "Launch k9s in vertical split" })
km.set("n", "<leader>kh", ":K9s ctx<CR>", { desc = "Launch k9s in horizontal split" })

-- Context and namespace management
km.set("n", "<leader>kc", ":K9s context<CR>", { desc = "Change Kubernetes context" })
km.set("n", "<leader>kn", ":K9s namespace<CR>", { desc = "Change Kubernetes namespace" })

-- Resource viewing
km.set("n", "<leader>kp", ":K9s pods<CR>", { desc = "View pods in k9s" })
km.set("n", "<leader>kd", ":K9s deployments<CR>", { desc = "View deployments in k9s" })
km.set("n", "<leader>ks", ":K9s services<CR>", { desc = "View services in k9s" })
km.set("n", "<leader>ki", ":K9s ingresses<CR>", { desc = "View ingresses in k9s" })
km.set("n", "<leader>km", ":K9s configmaps<CR>", { desc = "View configmaps in k9s" })
km.set("n", "<leader>kS", ":K9s secrets<CR>", { desc = "View secrets in k9s" })
km.set("n", "<leader>kj", ":K9s jobs<CR>", { desc = "View jobs in k9s" })
km.set("n", "<leader>kr", ":K9s file<CR>", { desc = "View resource from current file" })

-- Logs viewing
km.set("n", "<leader>kl", ":K9sLogs<CR>", { desc = "View logs for resource" })
km.set("n", "<leader>kL", function()
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
km.set("n", "<leader>ka", function()
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

-- Generate kubernetes YAML templates
km.set("n", "<leader>kg", function()
  -- Define template types
  local templates = {
    "deployment",
    "service",
    "configmap",
    "secret",
    "ingress",
    "statefulset",
    "daemonset",
    "job",
    "cronjob",
    "namespace",
  }

  -- Let user select template type
  vim.ui.select(templates, {
    prompt = "Select resource type:",
  }, function(resource_type)
    if not resource_type then
      return
    end

    -- Ask for resource name
    vim.ui.input({
      prompt = "Resource name: ",
    }, function(name)
      if not name or name == "" then
        return
      end

      -- Ask for namespace
      vim.ui.input({
        prompt = "Namespace (default): ",
      }, function(namespace)
        if not namespace or namespace == "" then
          namespace = "default"
        end

        -- Generate template based on resource type
        local template
        if resource_type == "deployment" then
          template = string.format(
            [[
apiVersion: apps/v1
kind: Deployment
metadata:
  name: %s
  namespace: %s
spec:
  replicas: 1
  selector:
    matchLabels:
      app: %s
  template:
    metadata:
      labels:
        app: %s
    spec:
      containers:
      - name: %s
        image: nginx:latest
        resources:
          limits:
            cpu: 200m
            memory: 256Mi
          requests:
            cpu: 100m
            memory: 128Mi
]],
            name,
            namespace,
            name,
            name,
            name
          )
        elseif resource_type == "service" then
          template = string.format(
            [[
apiVersion: v1
kind: Service
metadata:
  name: %s
  namespace: %s
spec:
  selector:
    app: %s
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
]],
            name,
            namespace,
            name
          )
        elseif resource_type == "configmap" then
          template = string.format(
            [[
apiVersion: v1
kind: ConfigMap
metadata:
  name: %s
  namespace: %s
data:
  # Add data here
  key: value
]],
            name,
            namespace
          )
        elseif resource_type == "secret" then
          template = string.format(
            [[
apiVersion: v1
kind: Secret
metadata:
  name: %s
  namespace: %s
type: Opaque
data:
  # Base64 encoded values
  username: dXNlcm5hbWU=  # username
  password: cGFzc3dvcmQ=  # password
]],
            name,
            namespace
          )
        elseif resource_type == "ingress" then
          template = string.format(
            [[
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: %s
  namespace: %s
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: %s.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: %s
            port:
              number: 80
]],
            name,
            namespace,
            name,
            name
          )
        elseif resource_type == "statefulset" then
          template = string.format(
            [[
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: %s
  namespace: %s
spec:
  serviceName: %s
  replicas: 1
  selector:
    matchLabels:
      app: %s
  template:
    metadata:
      labels:
        app: %s
    spec:
      containers:
      - name: %s
        image: nginx:latest
]],
            name,
            namespace,
            name,
            name,
            name,
            name
          )
        elseif resource_type == "namespace" then
          template = string.format(
            [[
apiVersion: v1
kind: Namespace
metadata:
  name: %s
]],
            name
          )
        else
          -- Generic template for other resource types
          template = string.format(
            [[
apiVersion: v1
kind: %s
metadata:
  name: %s
  namespace: %s
]],
            resource_type:gsub("^%l", string.upper),
            name,
            namespace
          )
        end

        -- Create new buffer with template
        vim.cmd("enew")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
        vim.bo.filetype = "yaml"

        -- Set buffer name
        local filename = resource_type .. "_" .. name .. ".yaml"
        vim.cmd("file " .. filename)
      end)
    end)
  end)
end, { desc = "Generate kubernetes YAML template" })

-- K8s validation
km.set("n", "<leader>vk", ":term kubectl validate<CR>", { desc = "Validate Kubernetes manifests" })
km.set("n", "<leader>vy", ":term yamllint %<CR>", { desc = "Validate YAML with yamllint" })

-- Navigate to Kubernetes directory
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

return {}
