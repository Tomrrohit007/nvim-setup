local opt = vim.opt
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 2
opt.spell = true
opt.spelllang = { "en_us" }

vim.g.lazyvim_blink_main = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.cmd("cnoreabbrev qa qa!")

vim.cmd("set noswapfile")
opt.directory = vim.fn.stdpath("state")
opt.backupdir = vim.fn.stdpath("state")
opt.undodir = vim.fn.stdpath("state")
