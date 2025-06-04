return {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
    lazy = false,
    config = function()
        require("oil").setup({
            keymaps = {
                ["<C-s>"] = false,
            },
            view_options = {
                show_hidden = true
            }
        })
    end
}
