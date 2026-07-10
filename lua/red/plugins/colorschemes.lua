return {
    "luisiacc/gruvbox-baby",
    branch = "main",
    lazy = false,
    priority = 1000,
    config = function()
        -- Example config in Lua
        vim.g.gruvbox_baby_function_style = "NONE"
        vim.g.gruvbox_baby_keyword_style = "NONE"
        vim.g.gruvbox_baby_comment_style = "NONE"
        vim.g.gruvbox_baby_background_color = "dark"

        -- Each highlight group must follow the structure:
        -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
        -- See also :h highlight-guifg
        -- Example:

        -- Enable telescope theme
        vim.g.gruvbox_baby_telescope_theme = 0

        -- Enable transparent mode
        vim.g.gruvbox_baby_transparent_mode = 0

        -- Load the colorscheme
        vim.cmd [[colorscheme gruvbox-baby]]
    end
}
