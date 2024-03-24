return {
  "thePrimeagen/git-worktree.nvim",
  config = function()
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")

    vim.keymap.set("n", "<leader>lwt", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
    vim.keymap.set("n", "<leader>cwt", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
  end
}
