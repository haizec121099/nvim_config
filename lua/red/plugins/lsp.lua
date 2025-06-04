return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" }
    },
    config = function()
        vim.opt.signcolumn = "yes"

        local lspconfig = require("lspconfig")

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig.util.default_config.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = "LSP Actions",
            callback = function(ev)
                local opts = { buffer = ev.buffer }
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>nt", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>fcb", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "]r", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end
        })

        local servers = {
            volar = {
                filetypes = { 'vue', 'javascript', 'typescript'},
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                    typescript = {
                        tsdk = '<path_to>/lib/node_modules/typescript/lib',
                    },
                },
            },
        },

        require("mason").setup()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup(server)
                end
            }
        })

        local cmp = require("cmp")

        cmp.setup({
            sources = {
                { name = "nvim_lsp" }
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({})
        })
    end
}
