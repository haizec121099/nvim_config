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
                vim.keymap.set("n", "<leader>fc", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("n", "]r", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<C-r>", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end
        })

        require("mason").setup()
        require("mason-lspconfig").setup({})

        -- vim.lsp.config["vue_ls"] = {
        --     filetypes = { 'vue', 'javascript', 'typescript' },
        --     init_options = {
        --         vue = {
        --             hybridMode = false,
        --         },
        --     },
        -- }
        --
        -- local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
        -- '/vue-language-server' .. '/node_modules/@vue/language-server'
        -- local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
        -- local vue_plugin = {
        --     name = '@vue/typescript-plugin',
        --     location = vue_language_server_path,
        --     languages = { 'vue' },
        --     configNamespace = 'typescript',
        -- }
        -- local vtsls_config = {
        --     settings = {
        --         vtsls = {
        --             tsserver = {
        --                 globalPlugins = {
        --                     vue_plugin,
        --                 },
        --             },
        --         },
        --     },
        --     filetypes = tsserver_filetypes,
        -- }
        --
        -- local ts_ls_config = {
        --     init_options = {
        --         plugins = {
        --             vue_plugin,
        --         },
        --     },
        --     filetypes = tsserver_filetypes,
        -- }
        --
        -- -- If you are on most recent `nvim-lspconfig`
        -- local vue_ls_config = {}
        -- -- If you are not on most recent `nvim-lspconfig` or you want to override
        -- local vue_ls_config = {
        --     on_init = function(client)
        --         client.handlers['tsserver/request'] = function(_, result, context)
        --             local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
        --             local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
        --             local clients = {}
        --
        --             vim.list_extend(clients, ts_clients)
        --             vim.list_extend(clients, vtsls_clients)
        --
        --             if #clients == 0 then
        --                 vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.',
        --                     vim.log.levels.ERROR)
        --                 return
        --             end
        --             local ts_client = clients[1]
        --
        --             local param = unpack(result)
        --             local id, command, payload = unpack(param)
        --             ts_client:exec_cmd({
        --                 title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        --                 command = 'typescript.tsserverRequest',
        --                 arguments = {
        --                     command,
        --                     payload,
        --                 },
        --             }, { bufnr = context.bufnr }, function(_, r)
        --                 local response = r and r.body
        --                 -- TODO: handle error or response nil here, e.g. logging
        --                 -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
        --                 local response_data = { { id, response } }
        --
        --                 ---@diagnostic disable-next-line: param-type-mismatch
        --                 client:notify('tsserver/response', response_data)
        --             end)
        --         end
        --     end,
        -- }
        -- -- nvim 0.11 or above
        -- vim.lsp.config('vtsls', vtsls_config)
        -- vim.lsp.config('vue_ls', vue_ls_config)
        -- vim.lsp.config('ts_ls', ts_ls_config)
        -- vim.lsp.enable({ 'vtsls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`

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
