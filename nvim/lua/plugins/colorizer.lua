return {
    "norcalli/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup({
            user_default_options = {
                css = true,
            }
        })
    end
}