vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }

require("catppuccin").setup({
    dim_inactive = {
        enabled = true,
        shade = "gray",
        percentage = 0.5,
    },
})

vim.cmd.colorscheme "catppuccin-mocha"
