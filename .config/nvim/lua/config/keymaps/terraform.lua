local km = vim.keymap

-- Terraform keymaps with prefix <leader>tf
km.set("n", "<leader>tff", ":! terraform fmt<CR>", { desc = "Terraform Format" })
km.set("n", "<leader>tfp", ":terminal terraform plan<CR>", { desc = "Terraform Plan" })
km.set("n", "<leader>tfa", ":terminal terraform apply<CR>", { desc = "Terraform Apply" })
km.set("n", "<leader>tfd", ":terminal terraform destroy<CR>", { desc = "Terraform Destroy" })
km.set("n", "<leader>tfi", ":terminal terraform init<CR>", { desc = "Terraform Init" })
km.set("n", "<leader>tfv", ":terminal terraform validate<CR>", { desc = "Terraform Validate" })
km.set("n", "<leader>tfo", ":terminal terraform output<CR>", { desc = "Terraform Output" })
km.set("n", "<leader>tfs", ":terminal terraform state list<CR>", { desc = "Terraform State List" })
km.set("n", "<leader>tfg", ":terminal terraform graph | dot -Tsvg > graph.svg<CR>", { desc = "Terraform Graph" })

-- Navigate to Terraform directory
km.set("n", "<leader>ct", function()
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
