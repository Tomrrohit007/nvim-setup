local function tailwindcss_config(capabilities, on_attach)
	return {
		capabilities = capabilities,
		on_attach = on_attach,
		init_options = {
			userLanguages = {
				typescriptreact = "javascriptreact",
				typescript = "javascript",
			},
		},
		filetypes = {
			"typescriptreact",
			"javascriptreact",
			"html",
			"css",
		},
		on_new_config = function(new_config, _)
			new_config.settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							-- { 'class[Name]*?="([^"]*)"', '"([^"]*)"' },
							-- { "class[Name]*?='([^']*)'", "'([^']*)'" },
							-- { "class[Name]*?=`([^`]*)`", "`([^`]*)`" },
							{ "className%s*=%s*{([^}]*)}", "['\"`]([^'\"`]*)['\"`]" },
						},
					},
				},
			}
		end,
		root_dir = function(fname)
			local allowed = { "typescriptreact", "javascriptreact", "html", "css" }
			local ft = vim.bo.filetype
			if vim.tbl_contains(allowed, ft) then
				return require("lspconfig.util").root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"package.json"
				)(fname)
			end
			return nil
		end,
	}
end

return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"eslint-lsp",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local lspconfig = require("lspconfig")

			vim.diagnostic.config({
				virtual_text = {
					source = "if_many",
					prefix = "●",
					spacing = 4,
					format = function(diagnostic)
						return string.format("%s (%s)", diagnostic.message, diagnostic.source)
					end,
				},
			})
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end

			local servers = {

				"eslint",
				-- "vtsls",
				-- "emmet_ls",
			}

			lspconfig.tailwindcss.setup(tailwindcss_config(capabilities, on_attach))
			lspconfig.vtsls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
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
							enable = false,
						},
					},
				},
			})

			--
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end
		end,
	},
}
