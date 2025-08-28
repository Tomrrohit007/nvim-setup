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
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end

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
			}

			for server, opts in pairs(servers) do
				lspconfig[server].setup(vim.tbl_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, opts))
			end
		end,
	},
}
