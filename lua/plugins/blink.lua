return {
	{
		"saghen/blink.cmp",

		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			completion = {
				documentation = {
					auto_show = true,
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
				default = { "lsp", "path", "snippets", "path" },
				providers = {
					snippets = {
						min_keyword_length = 2,
						score_offset = 4,
					},
					lsp = {
						min_keyword_length = 1,
						score_offset = 3,
					},

					path = { min_keyword_length = 3, score_offset = 2 },
					buffer = {
						min_keyword_length = 4,
						score_offset = 0,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			require("blink.cmp").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
