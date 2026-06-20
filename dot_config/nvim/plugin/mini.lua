vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.trailspace", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.align", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.move", version = "stable" },
})
require("mini.pairs").setup()
require("mini.trailspace").setup()
require("mini.align").setup()
require("mini.move").setup()
