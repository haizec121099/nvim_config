return {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
    lazy = false
    config = function()
        require("oil").setup()
    end
} 
