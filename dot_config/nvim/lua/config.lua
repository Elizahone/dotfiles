-- basic config
vim.opt.number = true
-- vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 5 -- keep 5 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.laststatus = 3
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type
vim.opt.inccommand = "split" --  enable incremental substitution preview
vim.opt.isfname:append("@-@")

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect,fuzzy" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit

local undodir = vim.fn.stdpath("data") .. "/undodir"
if
    vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory

vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.errorbells = false
vim.opt.encoding = "utf-8"


-- vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
-- vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory
vim.opt.clipboard:append("unnamedplus")




vim.opt.listchars = {
    tab = '▶ ',     -- 制表符
--    trail = '·',    -- 行尾多余空格
--    extends = '›',  -- 换行显示
--    precedes = '‹', -- 换行显示
--    nbsp = '␣',     -- 非断空格
--    space = '·',    -- 普通空格（一般建议用 lead 或 trail）
    lead = '·',     -- 仅行首前导空格
    multispace = '·' -- 连续空格优化
}
vim.opt.list = true


vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "highlight sletion on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})


vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})


-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
    desc = "Highlight references under cursor",
    callback = function()
        -- Only run if the cursor is not in insert mode
        if vim.fn.mode() == "n" then
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local supports_highlight = false
            for _, client in ipairs(clients) do
                if client.server_capabilities.documentHighlightProvider then
                    supports_highlight = true
                    break -- Found a supporting client, no need to check others
                end
            end

            -- 3. Proceed only if an LSP is active AND supports the feature
            if supports_highlight then
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
            end
        end
    end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("ModeChanged", {
    group = "LspReferenceHighlight",
    desc = "Clear highlights when entering insert mode",
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})

