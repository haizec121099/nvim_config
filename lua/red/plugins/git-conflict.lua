return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
        require("git-conflict").setup({
            default_mappings = {
                ours = "gco",
                theirs = "gct",
                none = "gc0",
                both = "gcb",
                next = "gcn",
                prev = "gcp",
            }
        })
    end
}
