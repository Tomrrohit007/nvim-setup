local opt = vim.opt
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 2
-- Leader key
vim.g.mapleader = " "
vim.g.lazyvim_blink_main = false

-- Use command syntax for noswapfile
vim.cmd("set noswapfile")
-- Directory settings
opt.directory = vim.fn.stdpath("state")
opt.backupdir = vim.fn.stdpath("state")
opt.undodir = vim.fn.stdpath("state")
