return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	version = "1.*",
	opts = {
		keymap = { preset = "enter" },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 5,
			},
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
					treesitter = { "lsp" },
				},
			},
		},
		sources = {
			providers = {
				lsp = { min_keyword_length = 2, score_offset = 4 },
				snippets = { min_keyword_length = 3, score_offset = 4 },
				path = { min_keyword_length = 4, score_offset = 2 },
				buffer = { min_keyword_length = 4, score_offset = 1 },
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
