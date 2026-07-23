return {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("minuet").setup({
            provider = "openai_fim_compatible",
            provider_options = {
                openai_fim_compatible = {
                    name = "Ollama",
                    model = "qwen2.5-coder:1.5b-instruct",
                    end_point = "http://localhost:11434/v1/completions",
                    stream = true,
                    api_key = "TERM",
                    optional = {
                        max_tokens = 256,
                        temperature = 0.2,
                        top_p = 0.9
                    }
                },
            },
            blink = {
                enable_auto_trigger = true, -- Force automatic stream evaluation
            }
        })
    end,
}
