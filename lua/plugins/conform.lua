return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			go = { "gofmt", "goimports" },
			html = { "prettierd" },
			css = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			prisma = { "prisma_format" },
		},

		format_on_save = {
			timeout_ms = 3000,
			lsp_fallback = true,
			async = false,
		},
	},

	config = function(_, opts)
		require("conform").setup(opts)
		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format buffer" })
	end,
}
