return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "saghen/blink.cmp" }
    },
    config = function()
        vim.opt.signcolumn = "yes"

        local lspconfig = require("lspconfig")

        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig.util.default_config.capabilities,
            require("blink.cmp").get_lsp_capabilities()
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
                vim.keymap.set("n", "<leader>fc", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "]r", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end
        })

        require("mason").setup()
        require("mason-lspconfig").setup({})

        vim.lsp.config['tailwindcss'] = {
            filetypes = {
                'html', 'css', 'scss', 'javascript',
                'typescript', 'vue', 'react', 'blade' -- Keep blade if you use frontend, remove php!
            },
        }
        vim.lsp.enable('tailwindcss')

        vim.lsp.config['intelephense'] = {
            settings = {
                intelephense = {
                    completion = {
                        propertyCase = "camel"
                    },
                    diagnostics = {
                        strictTypes = true
                    }
                }
            }
        }

        -- vim.lsp.config['phpantom'] = {
        --     cmd = { 'phpantom_lsp' },
        --     filetypes = { 'php' },
        --     root_markers = { 'composer.json', '.git' },
        -- }
        -- vim.lsp.enable('phpantom')

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                -- Intercept volar and ts_ls on attach and force their formatting capabilities to false
                if client and (client.name == "vue_ls" or client.name == "ts_ls") then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end
            end,
        })

        -- 2. Define structural configurations using Neovim 0.12 Native Config Methods
        local vue_plugin_path = vim.fn.stdpath('data') ..
            '/mason/packages/vue-language-server/node_modules/@vue/language-server'

        vim.lsp.config("vue_ls", {
            filetypes = { 'typescript', 'javascript', 'vue' },
            init_options = { vue = { hybridMode = false } }
        })

        vim.lsp.config("ts_ls", {
            filetypes = { 'typescript', 'javascript', 'vue' },
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_plugin_path,
                        languages = { 'vue' },
                    },
                },
            },
        })

        -- 3. Globally enable them
        vim.lsp.enable({ "vue_ls", "ts_ls" })
    end
}
