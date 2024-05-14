return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        'navarasu/onedark.nvim',
    },
    config = function()
        require("ibl").setup()
        require('onedark').setup {
            style = 'darker',
            transparent = true,
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'italic',
                variables = 'none'
            },
        }
        require('onedark').load()
        require('lualine').setup {
            option = { style = 'onedark' }
        }
    end
}
