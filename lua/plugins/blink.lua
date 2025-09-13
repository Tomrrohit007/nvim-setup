local function html_snippet_enabled()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1
	local before = line:sub(1, col)
	-- Check if inside quotes
	local dq = select(2, before:gsub('"', '"'))
	local sq = select(2, before:gsub("'", "'"))
	local bt = select(2, before:gsub("`", "`"))
	if (dq % 2 == 1) or (sq % 2 == 1) or (bt % 2 == 1) then
		return false
	end
	-- Get word before cursor (HTML/class/id style)
	local word = before:match("[%w#%-_]*$")
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
				documentation = { auto_show = true },
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
					show_on_keyword = true,
				},
			},
			sources = {
				default = { "snippets", "lsp", "path", "buffer" },
				providers = {
					snippets = {
						min_keyword_length = 1,
						score_offset = 1000,
						enabled = html_snippet_enabled,
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
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},
}
