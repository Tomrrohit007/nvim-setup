return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"cssls", -- css-lsp
				"dockerls", -- dockerfile-language-server
				"emmet_ls", -- emmet-ls
				"html", -- html-lsp
				"jsonls", -- json-lsp
				"lua_ls", -- lua-language-server
				"prismals", -- prisma-language-server
				"superhtml",
				"tailwindcss",
				"ts_ls", -- typescript-language-server
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			local servers = {
				cssls = {},
				dockerls = {},
				emmet_ls = {},
				html = {},
				jsonls = {},
				lua_ls = {},
				prismals = {},
				superhtml = {},
				tailwindcss = {},
				ts_ls = {},
			}

			for server, opts in pairs(servers) do
				lspconfig[server].setup(opts)
			end

			local keymap_opts = { noremap = true, silent = true }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
		end,
	},
}
