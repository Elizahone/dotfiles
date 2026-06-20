vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.pick", version = "stable" },
    { src = 'https://github.com/nvim-mini/mini.extra', version = 'stable' },
})

require("mini.extra").setup()
require("mini.pick").setup({
    mappings = {
        stop = '<C-g>',
        move_start = 'C-a',
    }
})

local wipeout_cur = function()
  vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
end
local buffer_mappings = { wipeout = { char = 'D', func = wipeout_cur } }

vim.keymap.set("n", "<leader>b", function() MiniPick.builtin.buffers(local_opts, { mappings = buffer_mappings }) end, {})
vim.keymap.set("n", "<leader>f", function() MiniPick.builtin.files() end, {})


-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- - "gra" (Normal and Visual mode) is mapped to |vim.lsp.buf.code_action()|
-- - "gri" is mapped to |vim.lsp.buf.implementation()|
-- - "grn" is mapped to |vim.lsp.buf.rename()|
-- - "grr" is mapped to |vim.lsp.buf.references()|
-- - "grt" is mapped to |vim.lsp.buf.type_definition()|
-- - "gO" is mapped to |vim.lsp.buf.document_symbol()|
-- - CTRL-S (Insert mode) is mapped to |vim.lsp.buf.signature_help()|
-- - |v_an| and |v_in| fall back to LSP |vim.lsp.buf.selection_range()| if
--   treesitter is not active.
-- - |gx| handles `textDocument/documentLink`. Example: with gopls, invoking gx
--   on "os" in this Go code will open documentation externally: >
--     package nvim
--     import (
--        "os"
--     )

vim.keymap.set("n", "gri", function() MiniExtra.pickers.lsp({ scope = "implementation" }) end, {})
vim.keymap.set("n", "grr", function() MiniExtra.pickers.lsp({ scope = "references" }) end, {})
vim.keymap.set("n", "grt", function() MiniExtra.pickers.lsp({ scope = "type_definition" }) end, {})
vim.keymap.set("n", "gO", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end, {})
vim.keymap.set("n", "grd", function() MiniExtra.pickers.lsp({ scope = "declaration" }) end, {})
