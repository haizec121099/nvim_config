return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            -- 1. Map the chat interaction to use Ollama
            strategies = {
                chat = {
                    adapter = "ollama",
                    keymaps = {
                        close = {
                            modes = {
                                n = "<leader>cl",
                                i = "<nop>"
                            },
                            index = 4,
                            callback = "keymaps.close",
                            description = "Close Chat",
                        }
                    }
                },
                inline = {
                    adapter = "ollama",
                },
                background = {
                    adapter = "ollama",
                },
            },
            prompt_library = {
                markdown = {
                    dirs = {
                        vim.fn.getcwd() .. "/lua/red/prompts", -- Can be relative
                    },
                },
            },
            -- 2. Configure the Ollama adapter to default to your Qwen model
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        schema = {
                            model = {
                                default = "qwen2.5-coder:3B", -- Your primary autocomplete/editing model
                            },
                        },
                    })
                end,
            },
            -- 3. UI Tweak (Optional: changes chat window layout to vertical)
            display = {
                chat = {
                    window = {
                        winbar = "%{%v:lua.require('codecompanion').buf_get_chat_title(0)%}",
                        layout = "vertical", -- options: vertical, horizontal, float
                        width = 0.30,        -- takes up 45% of screen width
                    },
                },
            },
        })

        -- 4. Keymaps to open and toggle the chat buffer
        vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
        vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Visual Selection to Chat" })
    end,
}
