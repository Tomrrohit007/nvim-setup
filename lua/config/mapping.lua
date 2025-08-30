local opt = vim.opt
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic options
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.relativenumber = true
opt.clipboard = "unnamedplus"

-- Leader key
vim.g.mapleader = " "
vim.g.lazyvim_blink_main = false

-- Copy visual selection to system clipboard
function copy_visual_selection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- Adjust first and last lines by column
	lines[1] = string.sub(lines[1], start_pos[3], #lines[1])
	lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

	local content = table.concat(lines, "\n")
	vim.fn.setreg("+", content)
	print("Copied to clipboard")
end

-- Wrap toggle functions
local function set_wrap()
	opt.wrap = true
	opt.linebreak = true
	map("n", "j", "gj", { noremap = true, silent = true })
	map("n", "k", "gk", { noremap = true, silent = true })
end

local function set_nowrap()
	opt.wrap = false
	opt.linebreak = false
	map("n", "j", "j", { noremap = true, silent = true })
	map("n", "k", "k", { noremap = true, silent = true })
end

-- === NEW MAPPINGS FROM NVCHAD/LAZYVIM === --

-- Better window navigation (NvChad)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Move lines up/down (LazyVim)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Terminal mappings (NvChad)
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- These always work across all terminals
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Visual mode versions
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- LSP mappings (LazyVim)
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
--
-- Yank mappings

map("n", "Y", function()
	vim.cmd("normal! yy")
	vim.notify("Yanked current line")
end, { noremap = true, silent = true })

-- Wrap toggle keymaps
map("n", "<leader>w", set_wrap, { noremap = true, silent = true })
map("n", "<leader>W", set_nowrap, { noremap = true, silent = true })

-- Diagnostic navigation
map("n", "<leader>ge", vim.diagnostic.goto_next, { noremap = true, silent = true })
map("n", "<leader>gE", vim.diagnostic.goto_prev, { noremap = true, silent = true })

-- 📊 TERMINAL LAYOUTS (Easy muscle memory)
map("n", "<leader>t", ":TermNew layout=below<CR>", opts) -- Below (b)ottom
map("n", "<leader>cv", ":TermNew layout=right<CR>", opts)
map("n", "<leader>tf", ":TermNew layout=float<CR>", opts) -- (F)loat
map("n", "<leader>ts", ":TermSend! new_line=false<CR>", opts) -- (S)end line

vim.cmd('cnoreabbrev <expr> w getcmdtype() == ":" && getcmdline() ==# "w" ? "wa" : "w"')

vim.cmd('cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() ==# "q" ? "qa" : "q"')
