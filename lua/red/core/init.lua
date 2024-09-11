vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.g.netrw_keepdir = 1
vim.g.netrw_banner = 0

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", function ()
  vim.cmd([[
    w
    noh
  ]])
end)

