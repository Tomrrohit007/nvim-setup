local function term_nav(dir)
	return function()
		local mode = vim.fn.mode()
		if mode == "t" then
			return ("<C-\\><C-N><C-%s>"):format(dir)
		else
			return ("<C-%s>"):format(dir)
		end
	end
end

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = {
				sources = {
					explorer = {
						layout = {
							layout = {
								width = 24,
							},
						},
					},
				},
			},
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			terminal = {
				win = {
					keys = {
						nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
						nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
						nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
						nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
					},
				},
			},
		},
		keys = {
			{
				"<S-n>",
				function()
					require("snacks").explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader><leader>",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("snacks").picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fb",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>gs",
				function()
					require("snacks").picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gl",
				function()
					require("snacks").picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"gd",
				function()
					require("snacks").picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gr",
				function()
					require("snacks").picker.lsp_references()
				end,
				desc = "Goto References",
			},
			{
				"gi",
				function()
					require("snacks").picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"<leader>.",
				function()
					require("snacks").scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					require("snacks").scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
		},
	},
}
