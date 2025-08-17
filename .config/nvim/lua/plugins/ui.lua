return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000, config=function ()
	   vim.cmd.colorscheme "catppuccin-mocha"
	end},
    },
    config = function()
        require("ibl").setup()
        require('lualine').setup {
            option = { style = 'catppuccin-mocha' }

        }
    end
}
