return {
    "echasnovski/mini.notify",
    version = false,
    config = function()
        require("mini.notify").setup({
            LspProgress = { enable = true }
        })
    end
}
