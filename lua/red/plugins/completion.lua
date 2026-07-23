return {
    "saghen/blink.cmp",
    build = "cargo build --release",
    lazy = false,
    event = "InsertEnter",
    version = "*",
    dependencies = {
        "rafamadriz/friendly-snippets", -- useful snippets
        "xzbdmw/colorful-menu.nvim"
    },
    opts = {
        keymap = {
            preset = "none", -- Disable presets to use your custom keys
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ['<A-y>'] = { function()
                require('minuet').make_blink_map()
            end },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "minuet" },
            providers = {
                -- Bridge the legacy nvim-cmp 'minuet' plugin into blink
                minuet = {
                    name = "minuet",
                    module = "minuet.blink",
                    score_offset = 100,
                    async = true, -- CRITICAL: Stops blink from blocking your UI thread
                    timeout_ms = 3000
                },
            },
        },
        completion = {
            list = { selection = { preselect = false, auto_insert = true } },
            menu = {
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
            documentation = {
                auto_show = true
            }
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "source.default" },
    config = function(_, opts)
        require("blink.cmp").setup(opts)

        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#ebdbb2", bg = "#242424" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#3c3836", bg = "#242424" })

        -- 2. Give the right-side source labels (LSP, minuet) color
        vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#665c54", italic = true })

        -- 3. Fix the "colorful-menu" fallback text if it looks too flat
        -- -- Gives the Function/Method items a solid green block with dark text
        vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#eebd35", bg = "#242424", })
        vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#eebd35", bg = "#242424", })

        -- Gives Variables/Properties a solid blue block with dark text
        vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#1f72ac", bg = "#242424", })
        vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#fb4934", bg = "#242424", })
        vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#1f72ac", bg = "#242424", })
    end
}
