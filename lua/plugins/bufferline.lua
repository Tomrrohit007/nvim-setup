return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		require("bufferline").setup({})
		vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "None" })
		vim.api.nvim_set_keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	end,
}
