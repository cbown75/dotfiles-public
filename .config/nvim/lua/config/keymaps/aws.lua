local km = vim.keymap

-- AWS operations with prefix <leader>oa
km.set("n", "<leader>oa", "<nop>", { desc = "AWS" })

km.set("n", "<leader>oap", function()
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

km.set("n", "<leader>oae", ":terminal aws ec2 describe-instances<CR>", { desc = "List EC2 instances" })
km.set("n", "<leader>oas", ":terminal aws s3 ls<CR>", { desc = "List S3 buckets" })
km.set("n", "<leader>oal", ":terminal aws lambda list-functions<CR>", { desc = "List Lambda functions" })
km.set("n", "<leader>oar", ":terminal aws rds describe-db-instances<CR>", { desc = "List RDS instances" })
km.set("n", "<leader>oac", ":terminal aws cloudformation list-stacks<CR>", { desc = "CloudFormation stacks" })
km.set("n", "<leader>oai", ":terminal aws sts get-caller-identity<CR>", { desc = "Show current identity" })

return {}
