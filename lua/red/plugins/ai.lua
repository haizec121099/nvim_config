return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            opts = {
                log_level = "DEBUG"
            },
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        schema = {
                            model = {
                                default = "qwen2.5-coder:3b-instruct",
                            },
                            num_ctx = {
                                default = 16384,
                            },
                        },
                        opts = {
                            stream = true,
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "ollama",
                    roles = {
                        user = "Redouin"
                    },
                    keymaps = {
                        send = {
                            modes = { n = "<C-s>" },
                            opts = {},
                        },
                        close = {
                            modes = { n = "<leader>cl", i = "<Plug>(codecompanion.close)" },
                            opts = {},
                        },
                    },
                },
            },
            display = {
                chat = {
                    window = {
                        width = 0.30
                    },
                    intro_message = "Ask the AI assistant anything related to coding."
                }
            }
        })

        vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true })
    end
}
