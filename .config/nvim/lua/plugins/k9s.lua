return {
  "nathom/tmux.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local Path = require("plenary.path")

    -- Create the k9s utilities
    _G.k9s_utils = {
      -- Current context cache to avoid repeated calls
      context_cache = { value = "", last_update = 0 },

      -- Get current kubernetes context
      get_current_context = function()
        -- Check cache first (valid for 30 seconds)
        local now = os.time()
        if now - _G.k9s_utils.context_cache.last_update < 30 and _G.k9s_utils.context_cache.value ~= "" then
          return _G.k9s_utils.context_cache.value
        end

        local handle = io.popen("kubectl config current-context 2>/dev/null")
        if not handle then
          vim.notify("Failed to get current kubernetes context", vim.log.levels.ERROR)
          return nil
        end

        local result = handle:read("*a")
        handle:close()

        result = result:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace

        -- Update cache
        _G.k9s_utils.context_cache.value = result
        _G.k9s_utils.context_cache.last_update = now

        return result
      end,

      -- Get current namespace from config
      get_current_namespace = function()
        local context = _G.k9s_utils.get_current_context()
        if not context then
          return "default"
        end

        local handle = io.popen(
          string.format(
            "kubectl config view -o jsonpath='{.contexts[?(@.name==\"%s\")].context.namespace}' 2>/dev/null",
            context
          )
        )

        if not handle then
          return "default"
        end

        local result = handle:read("*a")
        handle:close()

        result = result:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace

        -- If namespace is not set, return default
        if result == "" then
          return "default"
        end

        return result
      end,

      -- Launch k9s in a tmux pane
      launch_k9s = function(opts)
        opts = opts or {}

        -- If not in tmux, use terminal instead
        if not vim.env.TMUX then
          return _G.k9s_utils.launch_k9s_term(opts)
        end

        local cmd = "k9s"

        -- Add namespace if specified
        if opts.namespace then
          cmd = cmd .. " -n " .. opts.namespace
        end

        -- Add context if specified
        if opts.context then
          cmd = cmd .. " --context " .. opts.context
        end

        -- Launch in a horizontal or vertical split
        local split_cmd = opts.vertical and "split-window -h" or "split-window -v"
        local size = opts.size or "40%"

        -- Set size for the split
        if opts.vertical then
          split_cmd = split_cmd .. " -p " .. size
        else
          split_cmd = split_cmd .. " -p " .. size
        end

        -- Execute the command
        local tmux_cmd = string.format('tmux %s "%s"', split_cmd, cmd)
        vim.fn.system(tmux_cmd)

        vim.notify(
          "Launched k9s"
          .. (opts.context and (" with context: " .. opts.context) or "")
          .. (opts.namespace and (" in namespace: " .. opts.namespace) or ""),
          vim.log.levels.INFO
        )
      end,

      -- Launch k9s in a Neovim terminal (for when not in tmux)
      launch_k9s_term = function(opts)
        opts = opts or {}

        local cmd = "k9s"

        -- Add namespace if specified
        if opts.namespace then
          cmd = cmd .. " -n " .. opts.namespace
        end

        -- Add context if specified
        if opts.context then
          cmd = cmd .. " --context " .. opts.context
        end

        -- Create a new split
        if opts.vertical then
          vim.cmd("vsplit")
        else
          vim.cmd("split")
        end

        -- Resize the split
        local size = opts.size or "40%"
        if opts.vertical then
          vim.cmd("vertical resize " .. size)
        else
          vim.cmd("resize " .. size)
        end

        -- Open terminal with k9s
        vim.cmd("terminal " .. cmd)

        -- Enter insert mode to interact with terminal
        vim.cmd("startinsert")

        vim.notify(
          "Launched k9s"
          .. (opts.context and (" with context: " .. opts.context) or "")
          .. (opts.namespace and (" in namespace: " .. opts.namespace) or ""),
          vim.log.levels.INFO
        )
      end,

      -- Switch context and launch k9s
      switch_context_and_launch = function(vertical)
        -- Get list of contexts
        local handle = io.popen("kubectl config get-contexts -o name 2>/dev/null")
        if not handle then
          vim.notify("Failed to get kubernetes contexts", vim.log.levels.ERROR)
          return
        end

        local contexts = {}
        for context in handle:lines() do
          table.insert(contexts, context)
        end
        handle:close()

        -- Use vim.ui.select to choose a context
        vim.ui.select(contexts, {
          prompt = "Select Kubernetes Context:",
          format_item = function(item)
            local current = _G.k9s_utils.get_current_context()
            if current and item == current then
              return item .. " (current)"
            end
            return item
          end,
        }, function(choice)
          if choice then
            -- Switch context first
            vim.fn.system("kubectl config use-context " .. choice)

            -- Then launch k9s
            _G.k9s_utils.launch_k9s({
              context = choice,
              vertical = vertical or false,
            })

            -- Reset context cache
            _G.k9s_utils.context_cache = { value = "", last_update = 0 }
          end
        end)
      end,

      -- Select namespace and launch k9s
      select_namespace_and_launch = function(vertical)
        local context = _G.k9s_utils.get_current_context()
        if not context then
          vim.notify("No kubernetes context found", vim.log.levels.ERROR)
          return
        end

        -- Get list of namespaces
        local handle = io.popen("kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' 2>/dev/null")
        if not handle then
          vim.notify("Failed to get kubernetes namespaces", vim.log.levels.ERROR)
          return
        end

        local result = handle:read("*a")
        handle:close()

        local namespaces = {}
        for namespace in result:gmatch("%S+") do
          table.insert(namespaces, namespace)
        end

        -- Use vim.ui.select to choose a namespace
        vim.ui.select(namespaces, {
          prompt = "Select Kubernetes Namespace:",
          format_item = function(item)
            local current = _G.k9s_utils.get_current_namespace()
            if current and item == current then
              return item .. " (current)"
            end
            return item
          end,
        }, function(choice)
          if choice then
            -- Launch k9s with selected namespace
            _G.k9s_utils.launch_k9s({
              namespace = choice,
              context = context,
              vertical = vertical or false,
            })
          end
        end)
      end,

      -- Get resources from current file and launch k9s
      resource_from_file = function(vertical)
        local bufnr = vim.api.nvim_get_current_buf()
        local filetype = vim.bo[bufnr].filetype

        -- Only proceed if file is yaml or json
        if filetype ~= "yaml" and filetype ~= "json" then
          vim.notify("Current file is not YAML or JSON", vim.log.levels.WARN)
          return
        end

        -- Get the content
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local content = table.concat(lines, "\n")

        -- Try to extract resource kind and name
        local kind, name, namespace

        -- Extract from YAML
        kind = content:match("kind:%s*([%w-]+)")
        if kind then
          name = content:match("name:%s*([%w-]+)")
          namespace = content:match("namespace:%s*([%w-]+)")
        end

        -- If we have a kind and name, launch k9s
        if kind and name then
          kind = kind:lower() -- k9s uses lowercase resource types

          -- Some resources are referenced differently in k9s
          local resource_map = {
            deployment = "deploy",
            statefulset = "sts",
            daemonset = "ds",
            service = "svc",
            ingress = "ing",
            configmap = "cm",
            persistentvolumeclaim = "pvc",
            persistentvolume = "pv",
            serviceaccount = "sa",
          }

          local k9s_kind = resource_map[kind:lower()] or kind

          -- Launch k9s targeting this resource
          _G.k9s_utils.launch_k9s({
            namespace = namespace or _G.k9s_utils.get_current_namespace(),
            vertical = vertical or false,
            resource = k9s_kind,
            resource_name = name,
          })

          vim.notify("Launching k9s for " .. kind .. "/" .. name, vim.log.levels.INFO)
        else
          vim.notify("Could not detect kubernetes resource in file", vim.log.levels.WARN)
        end
      end,
    }

    -- Register our k9s commands
    vim.api.nvim_create_user_command("K9s", function(opts)
      local args = opts.args

      if args == "" then
        -- Default: launch k9s with current context and namespace
        _G.k9s_utils.launch_k9s()
      elseif args == "context" or args == "ctx" then
        -- Select context and launch
        _G.k9s_utils.switch_context_and_launch()
      elseif args == "namespace" or args == "ns" then
        -- Select namespace and launch
        _G.k9s_utils.select_namespace_and_launch()
      elseif args == "file" or args == "f" then
        -- Parse current file and launch
        _G.k9s_utils.resource_from_file()
      elseif args == "vcontext" or args == "vctx" then
        -- Select context and launch vertical split
        _G.k9s_utils.switch_context_and_launch(true)
      elseif args == "vnamespace" or args == "vns" then
        -- Select namespace and launch vertical split
        _G.k9s_utils.select_namespace_and_launch(true)
      elseif args == "vfile" or args == "vf" then
        -- Parse current file and launch vertical split
        _G.k9s_utils.resource_from_file(true)
      else
        -- Try to interpret as a resource type
        _G.k9s_utils.launch_k9s({
          resource = args,
        })
      end
    end, {
      nargs = "?",
      complete = function(ArgLead, CmdLine, CursorPos)
        local suggestions = {
          "context",
          "ctx",
          "namespace",
          "ns",
          "file",
          "f",
          "vcontext",
          "vctx",
          "vnamespace",
          "vns",
          "vfile",
          "vf",
          -- Common k8s resource types
          "pods",
          "deployments",
          "services",
          "configmaps",
          "secrets",
          "ingresses",
          "statefulsets",
          "daemonsets",
          "jobs",
          "cronjobs",
        }

        if ArgLead == "" then
          return suggestions
        end

        local results = {}
        for _, suggestion in ipairs(suggestions) do
          if suggestion:find(ArgLead, 1, true) == 1 then
            table.insert(results, suggestion)
          end
        end

        return results
      end,
      desc = "Launch k9s with various options",
    })

    -- For tmux split with live logs and code editing
    vim.api.nvim_create_user_command("K9sLogs", function(opts)
      local args = opts.args
      local resource_type, resource_name

      -- Try to parse arguments as type/name
      if args:find("/") then
        resource_type, resource_name = args:match("([^/]+)/(.+)")
      else
        resource_name = args

        -- Try to detect resource type from current file
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local content = table.concat(lines, "\n")

        local kind = content:match("kind:%s*([%w-]+)")
        if kind then
          resource_type = kind:lower()

          -- Map to k9s abbreviations
          local resource_map = {
            deployment = "deploy",
            statefulset = "sts",
            daemonset = "ds",
            service = "svc",
            ingress = "ing",
            configmap = "cm",
          }

          resource_type = resource_map[resource_type] or resource_type
        else
          resource_type = "pod" -- Default to pod
        end
      end

      -- If running in tmux, create a split view
      if vim.env.TMUX then
        -- Create a vertical or horizontal split based on window dimensions
        local width = vim.o.columns
        local height = vim.o.lines

        local split_cmd
        if width > height * 2 then
          -- Wide screen, use vertical split
          split_cmd = "split-window -h -p 40"
        else
          -- Tall or square screen, use horizontal split
          split_cmd = "split-window -v -p 40"
        end

        -- Construct the kubectl logs command with follow
        local logs_cmd = string.format("kubectl logs -f %s/%s", resource_type, resource_name)

        -- Execute the command in tmux
        vim.fn.system(string.format('tmux %s "%s"', split_cmd, logs_cmd))

        vim.notify("Started logs for " .. resource_type .. "/" .. resource_name, vim.log.levels.INFO)
      else
        -- Not in tmux, use a Neovim split
        vim.cmd("vsplit")
        vim.cmd("terminal kubectl logs -f " .. resource_type .. "/" .. resource_name)
        vim.cmd("startinsert")
      end
    end, {
      nargs = "?",
      complete = function(ArgLead, CmdLine, CursorPos)
        -- If we're completing the first part (resource type)
        if not CmdLine:find("/") then
          local resource_types = {
            "pod/",
            "deployment/",
            "deploy/",
            "statefulset/",
            "sts/",
            "daemonset/",
            "ds/",
            "job/",
            "cronjob/",
            "service/",
            "svc/",
          }

          if ArgLead == "" then
            return resource_types
          end

          local results = {}
          for _, rt in ipairs(resource_types) do
            if rt:find(ArgLead, 1, true) == 1 then
              table.insert(results, rt)
            end
          end

          return results
        else
          -- We're completing the resource name
          local prefix = CmdLine:match("K9sLogs%s+([^%s/]+)/")

          if not prefix then
            return {}
          end

          -- Map back to kubectl resource types
          local kubectl_map = {
            deploy = "deployment",
            sts = "statefulset",
            ds = "daemonset",
            svc = "service",
            ing = "ingress",
            cm = "configmap",
          }

          local resource_type = kubectl_map[prefix] or prefix

          -- Get the namespace
          local namespace = _G.k9s_utils.get_current_namespace()

          -- Get the resources of this type
          local handle = io.popen(
            string.format(
              "kubectl get %s -n %s -o name 2>/dev/null | cut -d'/' -f2",
              resource_type,
              namespace
            )
          )

          if not handle then
            return {}
          end

          local resources = {}
          for resource in handle:lines() do
            table.insert(resources, resource)
          end
          handle:close()

          -- Filter by ArgLead
          local resource_prefix = ArgLead:match("[^/]+/(.*)") or ""

          if resource_prefix == "" then
            return resources
          end

          local filtered = {}
          for _, resource in ipairs(resources) do
            if resource:find(resource_prefix, 1, true) == 1 then
              table.insert(filtered, resource)
            end
          end

          return filtered
        end
      end,
      desc = "Show and follow logs for a kubernetes resource",
    })
  end,
}
