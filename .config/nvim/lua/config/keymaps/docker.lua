local km = vim.keymap

-- Docker operations with prefix <leader>d
km.set("n", "<leader>dcu", ":terminal docker-compose up -d<CR>", { desc = "Docker-compose up" })
km.set("n", "<leader>dcd", ":terminal docker-compose down<CR>", { desc = "Docker-compose down" })
km.set("n", "<leader>dl", ":terminal docker ps<CR>", { desc = "List Docker containers" })
km.set("n", "<leader>di", ":terminal docker images<CR>", { desc = "List Docker images" })
km.set("n", "<leader>dp", ":terminal docker pull<Space>", { desc = "Docker pull" })
km.set("n", "<leader>db", ":terminal docker build -t<Space>", { desc = "Docker build" })
km.set("n", "<leader>de", ":terminal docker exec -it<Space>", { desc = "Docker exec" })
km.set("n", "<leader>dr", ":terminal docker run -it<Space>", { desc = "Docker run" })
km.set("n", "<leader>ds", ":terminal docker stop<Space>", { desc = "Docker stop" })
km.set("n", "<leader>dx", ":terminal docker rm<Space>", { desc = "Docker remove" })

-- Docker validation
km.set("n", "<leader>vd", ":term hadolint %<CR>", { desc = "Validate Dockerfile with hadolint" })

return {}
