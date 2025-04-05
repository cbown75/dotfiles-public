local km = vim.keymap

-- Docker operations with prefix <leader>od
km.set("n", "<leader>od", "<nop>", { desc = "Docker" })
km.set("n", "<leader>odc", ":terminal docker-compose up -d<CR>", { desc = "Docker-compose up" })
km.set("n", "<leader>odd", ":terminal docker-compose down<CR>", { desc = "Docker-compose down" })
km.set("n", "<leader>odl", ":terminal docker ps<CR>", { desc = "List Docker containers" })
km.set("n", "<leader>odi", ":terminal docker images<CR>", { desc = "List Docker images" })
km.set("n", "<leader>odp", ":terminal docker pull<Space>", { desc = "Docker pull" })
km.set("n", "<leader>odb", ":terminal docker build -t<Space>", { desc = "Docker build" })
km.set("n", "<leader>ode", ":terminal docker exec -it<Space>", { desc = "Docker exec" })
km.set("n", "<leader>odr", ":terminal docker run -it<Space>", { desc = "Docker run" })
km.set("n", "<leader>ods", ":terminal docker stop<Space>", { desc = "Docker stop" })
km.set("n", "<leader>odx", ":terminal docker rm<Space>", { desc = "Docker remove" })

return {}
