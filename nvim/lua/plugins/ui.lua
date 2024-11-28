return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
	   'AlexvZyl/nordic.nvim',
    	lazy = false,
    	priority = 1000,
    	config = function()
        	require('nordic').load()
    	end
	},
    },
    config = function()
        require("ibl").setup()
        require('lualine').setup {
            option = { style = 'nordic' }

        }
    end
}
