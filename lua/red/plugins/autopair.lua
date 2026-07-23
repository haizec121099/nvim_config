return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "saghen/blink.cmp",
    },
    config = function()
        -- import nvim-autopairs
        local autopairs = require("nvim-autopairs")

        -- configure autopairs
        autopairs.setup({
            check_ts = true, -- enable treesitter
            map_cr = false,
            ts_config = {
                php = { "argument_list", "parameters" },
                lua = { "string" },                 -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
                java = false,                       -- don't check treesitter on java
            },
        })
    end,
}
