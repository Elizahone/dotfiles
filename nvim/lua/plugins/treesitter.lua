return {
    "nvim-treesitter/nvim-treesitter",
    main = 'nvim-treesitter.configs',
    built = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp","python" },
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
    }
}
