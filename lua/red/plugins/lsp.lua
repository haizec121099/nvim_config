return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "saghen/blink.cmp" },
        {
            "jedrzejboczar/devcontainers.nvim",
            lazy = false,
            config = function()
                require("devcontainers").setup({
                    autostart = false,
                    watch_configured_backends = false,
                })
            end
        },
        { "seblyng/roslyn.nvim",              ft = { "cs", "razor" } },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        vim.opt.signcolumn = "yes"
        require('mason').setup({})
        require('mason-lspconfig').setup({})

        -- Setup standard autocompletion capabilities
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local function get_lsp_cmd(base_cmd)
            -- local has_devcontainer = vim.fn.isdirectory(vim.fn.getcwd() .. "/.devcontainer") == 1
            --
            -- local is_docker_online = false
            -- if has_devcontainer then
            --     vim.fn.system("docker info")
            --     is_docker_online = vim.v.shell_error == 0
            -- end

            -- if has_devcontainer and is_docker_online then
            --     return require('devcontainers').lsp_cmd(base_cmd)
            -- else
            --     if base_cmd[1] == "roslyn" then
            --         base_cmd[1] = vim.fn.stdpath("data") .. "/mason/bin/roslyn"
            --     end
            return base_cmd
            --end
        end

        -- 1. GOLANG (gopls)
        vim.lsp.config('gopls', {
            cmd = get_lsp_cmd({ 'gopls' }),
            capabilities = capabilities,
            root_markers = { "go.mod" }
        })

        -- 2. VUE (vue_ls / volar)
        vim.lsp.config('vue_ls', {
            cmd = get_lsp_cmd({ 'vue-language-server', '--stdio' }),
            capabilities = capabilities,
            root_markers = { "package.json" }
        })

        vim.lsp.config('nil_ls', {
            cmd = get_lsp_cmd({ 'nil' }),
            capabilities = capabilities,
            filetypes = { "nix" },
            settings = {
                ["nil"] = {
                    formatting = {
                        command = { "alejandra" }
                    }
                }
            }
        })

        -- 3. TYPESCRIPT & JAVASCRIPT (ts_ls)
        vim.lsp.config('ts_ls', {
            cmd = get_lsp_cmd({ 'typescript-language-server', '--stdio' }),
            capabilities = capabilities,
            root_markers = { "package.json" },
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '/usr/local/lib/node_modules/@vue/language-server',
                        languages = { 'vue' },
                    },
                },
            },
        })

        -- 4. PHP (intelephense)
        -- We combine the devcontainer command and your custom settings into ONE clean block!
        vim.lsp.config('intelephense', {
            cmd = get_lsp_cmd({ 'intelephense', '--stdio' }),
            capabilities = capabilities,
            filetypes = { 'php' },
            root_markers = { 'composer.json', '.git' },
            settings = {
                intelephense = {
                    completion = { propertyCase = "camel" },
                    diagnostics = { strictTypes = true },
                    files = {
                        maxSize = 5000000,
                        exclude = {
                            "**/node_modules/**",
                            "**/vendor/**/{Tests,tests}/**",
                            "**/vendor/**/Documentation/**",
                            "**/vendor/**/tutorials/**",

                            "**/storage/framework/cache/**",
                            "**/storage/framework/views/**",
                            "**/storage/framework/sessions/**",
                            "**/bootstrap/cache/**"
                        }
                    }
                }
            }
        })

        -- 5. TAILWIND
        vim.lsp.config('tailwindcss', {
            cmd = get_lsp_cmd({ 'tailwindcss', '--stdio' }),
            capabilities = capabilities,
            filetypes = { 'html', 'css', 'scss', 'javascript', 'typescript', 'vue', 'react', 'blade' },
            root_markers = { 'tailwind.config.js', 'package.json', '.git' },
        })

        require("roslyn").setup({
            args = { "roslyn-language-server", "--stdio" },
            broad_search = false, -- Only look inside your current directory structure
            config = {
                capabilities = capabilities,
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "openFiles",
                        dotnet_compiler_diagnostics_scope = "openFiles",
                    },
                    ["csharp|completion"] = {
                        dotnet_provide_regex_completions = true,
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                        dotnet_show_name_completion_suggestions = true,
                    },
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                },
            },
        })
        -- Shared LSP Actions / Keymaps
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

                -- Disable formatting for specialized frontend clients
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and (client.name == "vue_ls" or client.name == "ts_ls") then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end
            end
        })

        -- 5. Globally activate servers
        local servers = { "gopls", "ts_ls", "vue_ls", "intelephense", "tailwindcss", "nil_ls" }
        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end
    end
}
