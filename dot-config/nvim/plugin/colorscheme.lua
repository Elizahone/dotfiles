vim.pack.add {
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim", name = "gruvbox" },
    { src = "https://github.com/rose-pine/neovim", name = "rose-pine", },
}
require("catppuccin").setup({
    dim_inactive = {
        enabled = true,
        shade = "gray",
        percentage = 0.5,
    },
})

-- vim.cmd.colorscheme "catppuccin-mocha"


require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = false, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
-- vim.cmd("colorscheme gruvbox")


require("rose-pine").setup({
    variant = "moon",

    styles = {
        italic = false,
    },
    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        Visual = { fg = "overlay", bg = "text", inherit = false },
    },
})
vim.cmd("colorscheme rose-pine")
