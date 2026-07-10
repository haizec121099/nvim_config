return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        main = "nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
            "windwp/nvim-ts-autotag",
        },
        config = function()
            -- vim.filetype.add({
            --     extension = {
            --         php = "php",
            --     },
            -- })

            require('nvim-treesitter').setup({
                highlight = { enable = true }, -- Enables advanced parser colors
                indent = { enable = false },
            })

            local ensure_installed = { "lua", "python", "javascript", "rust", "go", "php", "bash" }

            -- Extract just the language names from the file paths found
            local parser_dir = vim.fn.expand("~/.local/share/nvim/site/parser/")
            local installed_langs = {}

            if vim.fn.isdirectory(parser_dir) == 1 then
                local files = vim.fn.readdir(parser_dir)
                for _, filename in ipairs(files) do
                    local lang = filename:match("^([^.]+)%.so$")
                    if lang then
                        installed_langs[lang] = true
                    end
                end
            end

            -- 5. Filter down to ONLY what is genuinely missing on your disk
            local parsers_to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not installed_langs[parser]
                end)
                :totable()

            -- 6. Trigger the install loop only if there are missing languages
            if #parsers_to_install > 0 then
                vim.notify("Treesitter: Auto-installing missing languages: " .. vim.inspect(parsers_to_install))
                require('nvim-treesitter').install(parsers_to_install)
            end

            -- vim.api.nvim_create_autocmd({ "FileType" }, {
            --     pattern = { "php" },
            --     callback = function()
            --         if require('nvim-treesitter.parsers').has_parser("php") then
            --             vim.treesitter.start()
            --         end
            --     end,
            -- })
        end,
    },
}
