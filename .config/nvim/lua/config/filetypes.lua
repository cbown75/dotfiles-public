-- ~/.config/nvim/lua/config/filetypes.lua
local function in_chart(path)
	return vim.fn.filereadable(vim.fs.dirname(path) .. "/Chart.yaml") == 1
end

vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
	pattern = {
		[".*[Dd]ockerfile.*"] = "dockerfile",
		["docker%-compose%..*%.ya?ml"] = "yaml.docker-compose",
		[".*/templates/.*%.ya?ml"] = "helm",
		[".*/templates/.*%.tpl"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
		[".*/values.*%.ya?ml"] = function(path)
			if in_chart(path) then
				return "yaml.helm-values"
			end
		end,
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*%.ya?ml"] = "yaml.ansible",
	},
})

vim.treesitter.language.register("yaml", { "yaml.docker-compose", "yaml.helm-values", "yaml.ansible" })
