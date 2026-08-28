return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup({
            registries = {
                "github:Crashdummyy/mason-registry", -- Contains the Roslyn package
                "github:mason-org/mason-registry",   -- Default Mason registry
            }
        })
    end,
}
