return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            format_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                javascript = {"prettierd", "prettier", stop_after_first = true},
                vue = {"prettierd", "prettier", stop_after_first = true},
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
