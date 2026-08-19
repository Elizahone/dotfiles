vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})

function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

require("oil").setup({
  columns = {
    "icon",
    "permissions",
    "size",
    -- "mtime",
  },
  win_options = {
    winbar = "%!v:lua.get_oil_winbar()",
  },
})

if vim.env.NVIM_CD_TMP then
    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            local ok, oil = pcall(require, "oil")
            local dir
            if ok then
                dir = oil.get_current_dir()
            end
            if not dir then
                dir = vim.fn.getcwd()
            end
            if dir then
                vim.fn.writefile({dir}, vim.env.NVIM_CD_TMP)
            end
        end,
        })
end
