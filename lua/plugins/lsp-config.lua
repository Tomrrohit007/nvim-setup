return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"eslint-lsp",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local lspconfig = vim.lsp
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end

			local servers = {

				"eslint",
				"tailwindcss",
			}

			lspconfig.config("vtsls", {
				capabilities = capabilities,
				on_attach = on_attach,
				root_markers = {
					".package.json",
					".package-lock.json",
					"tsconfig.json",
					".git",
				},

				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx" },
				settings = {
					typescript = {
						suggest = {
							completeFunctionCalls = false, -- keep disabled for performance
						},
						updateImportsOnFileMove = {
							enabled = "always",
						},
						diagnostics = {
							enable = false,
							reportUnusedDisableDirectives = false,
							reportDeprecated = false,
						},
						format = {
							enable = true,
						},
					},
				},
			})
			lspconfig.enable("vtsls")

			--
			for _, server in ipairs(servers) do
				lspconfig.config(server, {
					capabilities = capabilities,
					on_attach = on_attach,
					root_markers = {
						".git",
					},
				})
				lspconfig.enable(server)
			end
		end,
	},
}
