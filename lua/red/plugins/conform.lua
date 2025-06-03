return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            format_by_ft = {
                lua = {
                    function(bufnr)
                        return { "stylua" }
                    end
                },
                go = { "gofmt" },
                javascript = { "prettier" },
                vue = {
                    function(bufnr)
                        return { "prettier" }
                    end
                },
                php = { "pint" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end
}
