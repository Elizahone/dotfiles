require("core.basic")
require("lazy-plugins-setup")
vim.api.nvim_create_user_command("Run",
    function ()
        local extension = vim.fn.expand("%:e")
        local name = vim.fn.expand("%:r")
        if extension == "cpp" then
            vim.api.nvim_command("w")
            vim.api.nvim_command("term g++ % -o "..name..".out && ./"..name..".out")
        end
        if extension == "py" then
            vim.api.nvim_command("w")
            vim.api.nvim_command("term python %")
        end

    end,
    {nargs = 0}
)
