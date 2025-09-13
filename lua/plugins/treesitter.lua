return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Check if treesitter is available
			local ok, treesitter = pcall(require, "nvim-treesitter.configs")
			if not ok then
				return
			end

			treesitter.setup({
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "yaml" }, -- Some languages have indent issues
				},
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
					"go",
					"prisma",
				},
			})

			-- Create a command to toggle treesitter if needed
			vim.api.nvim_create_user_command("TSToggle", function()
				if vim.b.treesitter_disabled then
					vim.cmd([[TSBufEnable highlight]])
					vim.b.treesitter_disabled = false
					print("Treesitter highlighting enabled")
				else
					vim.cmd([[TSBufDisable highlight]])
					vim.b.treesitter_disabled = true
					print("Treesitter highlighting disabled")
				end
			end, {})
		end,
	},
}
