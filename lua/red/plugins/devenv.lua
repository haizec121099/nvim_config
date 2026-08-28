return {
    "NotAShelf/direnv.nvim",
    config = function()
        require("direnv").setup({
            bin = "direnv",
            autoload_direnv = true,
            keybindings = {
                allow = "<Leader>da",
                deny = "<Leader>dd",
                reload = "<Leader>dr",
                edit = "<Leader>de",
            },
            -- Statusline integration
            statusline = {
                -- Enable statusline component
                enabled = true,
                -- Icon to display in statusline
                icon = "󱚟",
            },


            -- Notification settings
            notifications = {
                -- Log level (vim.log.levels.INFO, ERROR, etc.)
                level = vim.log.levels.INFO,
                -- Don't show notifications during autoload
                silent_autoload = false,
            },
        })
    end,
}
