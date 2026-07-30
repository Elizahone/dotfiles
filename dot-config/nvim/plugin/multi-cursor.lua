vim.pack.add({ { src = "https://github.com/brenton-leighton/multiple-cursors.nvim" } })

require("multiple-cursors").setup({})

-- Multiple Cursors 键位映射
vim.keymap.set({"n", "x"}, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", {desc = "Add cursor and move down"})
vim.keymap.set({"n", "x"}, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", {desc = "Add cursor and move up"})

vim.keymap.set({"n", "i", "x"}, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {desc = "Add cursor and move up"})
vim.keymap.set({"n", "i", "x"}, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {desc = "Add cursor and move down"})

vim.keymap.set({"n", "i"}, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {desc = "Add or remove cursor"})

vim.keymap.set("x", "<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", {desc = "Add cursors to the lines of the visual area"})

vim.keymap.set({"n", "x"}, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", {desc = "Add cursors to cword"})
vim.keymap.set({"n", "x"}, "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", {desc = "Add cursors to cword in previous area"})

vim.keymap.set({"n", "x"}, "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", {desc = "Add cursor and jump to next cword"})
vim.keymap.set({"n", "x"}, "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", {desc = "Jump to next cword"})

vim.keymap.set({"n", "x"}, "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", {desc = "Lock virtual cursors"})
