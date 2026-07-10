vim.cmd("filetype plugin indent on")
vim.opt.number = true
vim.g.have_nerd_font = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.o.termguicolors = true
vim.g.netrw_keepdir = 1
vim.g.netrw_banner = 1
vim.o.winborder = 'rounded'

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
vim.keymap.set("n", "<C-s>", function()
    vim.cmd([[
    w
    noh
  ]])
end)

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        -- Safely try to start the built-in tree-sitter engine
        pcall(vim.treesitter.start)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    callback = function()
        -- Clear the legacy indent settings
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Fix baseline alignment flags
        vim.bo.autoindent = true
        vim.bo.smartindent = false
    end,
})

local group = vim.api.nvim_create_augroup("RememberFolds", { clear = true })

vim.api.nvim_create_autocmd('BufWinLeave', {
    desc = "Save Folds",
    pattern = "*",
    group = group,
    command = "silent! mkview"
})


vim.api.nvim_create_autocmd('BufWinEnter', {
    desc = "Restore Folds",
    pattern = "*",
    group = group,
    command = "silent! loadview"
})
