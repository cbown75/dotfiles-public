local km = vim.keymap

-- Terraform keymaps with prefix <leader>ot
km.set("n", "<leader>otf", ":! terraform fmt<CR>", { desc = "Terraform Format" })
km.set("n", "<leader>otp", ":terminal terraform plan<CR>", { desc = "Terraform Plan" })
km.set("n", "<leader>ota", ":terminal terraform apply<CR>", { desc = "Terraform Apply" })
km.set("n", "<leader>otd", ":terminal terraform destroy<CR>", { desc = "Terraform Destroy" })
km.set("n", "<leader>oti", ":terminal terraform init<CR>", { desc = "Terraform Init" })
km.set("n", "<leader>oto", ":terminal terraform output<CR>", { desc = "Terraform Output" })
km.set("n", "<leader>ots", ":terminal terraform state list<CR>", { desc = "Terraform State List" })
km.set("n", "<leader>otg", ":terminal terraform graph | dot -Tsvg > graph.svg<CR>", { desc = "Terraform Graph" })

-- Navigate to Terraform directory
km.set("n", "<leader>cot", function()
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
