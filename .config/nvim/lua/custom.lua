vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
-- 缩进设置 ：tab使用空格而不是制表符
vim.opt.expandtab = true
vim.opt.cmdheight = 1
vim.opt.smartindent = true

-- 搜索设置
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- 终端真颜色
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- 默认新窗口在右或下
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)


--   keymap

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set("i", "<C-;>", "<Esc>", { desc = "I use `Ctrl+;` to switch to normal mode"})

