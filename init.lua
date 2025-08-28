local opt = vim.opt

-- Basic options
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.relativenumber = true
opt.clipboard = "unnamedplus"

-- Leader key
vim.g.mapleader = " "

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
  vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
  vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
end

local function set_nowrap()
  opt.wrap = false
  opt.linebreak = false
  vim.keymap.set("n", "j", "j", { noremap = true, silent = true })
  vim.keymap.set("n", "k", "k", { noremap = true, silent = true })
end

-- Indent in visual mode and keep selection
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- Yank mappings
vim.keymap.set("n", "Y", "yy", { noremap = true })
vim.keymap.set("v", "<C-c>", copy_visual_selection, { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", function()
  vim.fn.setreg("+", vim.fn.getline("."))
end, { noremap = true, silent = true })

-- Wrap toggle keymaps
vim.keymap.set("n", "<leader>w", set_wrap, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>W", set_nowrap, { noremap = true, silent = true })

-- Diagnostic navigation
vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gE", vim.diagnostic.goto_prev, { noremap = true, silent = true })

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
