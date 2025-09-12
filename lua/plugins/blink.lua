local function get_word_before_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1
	return line:sub(1, col):match("[%w#%-]*$") -- dropped `.`
end

local function in_quotes()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1
	local before_cursor = line:sub(1, col)

	local dq = select(2, before_cursor:gsub('"', ""))
	local sq = select(2, before_cursor:gsub("'", ""))
	local bt = select(2, before_cursor:gsub("`", ""))
	return (dq % 2 == 1) or (sq % 2 == 1) or (bt % 2 == 1)
end

local function valid_html_snippet_context()
	if in_quotes() then
		return false
	end
	local word = get_word_before_cursor()
	return word and word ~= ""
end

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
				trigger = {
					-- Show completion when typing HTML elements
					show_on_keyword = true,
				},
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
				providers = {
					snippets = {
						min_keyword_length = 1,
						score_offset = 1000,
						enabled = valid_html_snippet_context,
					},
					lsp = {
						min_keyword_length = 2,
						score_offset = 1,
					},
					path = { min_keyword_length = 3, score_offset = 3 },
					buffer = {
						min_keyword_length = 3,
						score_offset = 4,
					},
				},
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = { "score", "sort_text" },
				-- Boost exact matches for HTML elements
				use_frecency = true,
				use_proximity = true,
			},

			performance = {
				debounce = 150,
				throttle = 150,
				fetching_timeout = 500,
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Additional performance optimization for snippets
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},
}
