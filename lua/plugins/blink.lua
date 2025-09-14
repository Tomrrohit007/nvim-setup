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
			completion = {
				documentation = { auto_show = true },
				menu = {
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
							},
						},
					 	-- columns = {
						-- 	{ "label", "label_description", gap = 1 },
						-- 	{ "kind_icon", "kind" },
						-- },
						-- treesitter = { "lsp" },
					},
				},
				trigger = {
					show_on_keyword = true,
				},
			},
			sources = {
				default = { "snippets", "lsp", "path", "buffer" },
				providers = {
					snippets = {
						min_keyword_length = 1,
						score_offset = 1,
						max_items = 4,
					},
					lsp = {
						min_keyword_length = 1,
						score_offset = 5,
						async = true,
						max_items = 3,
					},
					path = { min_keyword_length = 3, score_offset = 3 },
					buffer = {
						min_keyword_length = 3,
						score_offset = 5,
					},
				},
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",

				sorts = {
					"score",
					"sort_text",
				},
				use_frecency = true,
				use_proximity = true,
			},
		},
		config = function(_, opts)
			require("blink.cmp").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},
}
