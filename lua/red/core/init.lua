vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.o.termguicolors = true
vim.g.netrw_keepdir = 1
vim.g.netrw_banner = 1

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", function ()
  vim.cmd([[
    w
    noh
  ]])
end)

vim.api.nvim_create_autocmd('TextYankPost', {
   desc = "Highlight when yanking (copying) text",
   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
   callback = function ()
    vim.highlight.on_yank()
   end
})
