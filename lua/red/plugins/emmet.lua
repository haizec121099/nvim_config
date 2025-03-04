return {
  "mattn/emmet-vim",
  config = function()
        vim.g.user_emmet_leader_key=','
    -- set keymaps
        vim.g.user_emmet_install_global = 0
        vim.cmd [[
            autocmd FileType html,css,jsx,vue,blade.php EmmetInstall
        ]]
  end,
}
