return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			winopts = {
				height = 0.90,
				width = 0.85,
				border = "rounded",
				preview = {
					layout = "vertical",
					vertical = "down:45%",
				},
			},
			keymap = {
				builtin = {
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
				},
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			files = {
				prompt = "Files❯ ",
				git_icons = true,
			},
		},
	},
}
