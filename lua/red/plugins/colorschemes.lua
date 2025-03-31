return {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    config = function()
        vim.o.background="dark"
        vim.g.gruvbox_baby_keyword_style = "NONE"
        vim.g.gruvbox_baby_background_color = "dark"
        vim.cmd([[colorscheme gruvbox-baby]])
    end
}
