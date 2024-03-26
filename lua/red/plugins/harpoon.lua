return {
  "ThePrimeagen/harpoon",
  branch="harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local harpoon = require("harpoon")

    harpoon:setup()

    keymap.set("n", "<leader>hu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Show marked files"})

    keymap.set(
      "n",
      "<leader>hm",
      function() harpoon:list():append() end,
      { desc = "Mark file with harpoon" }
    )
    keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Go to next harpoon mark" })
    keymap.set(
      "n",
      "<leader>hb",
      function() harpoon:list():prev() end,
      { desc = "Go to previous harpoon mark" }
    )

    keymap.set("n", "<C-q>", function() harpoon:list():select(1) end)
    keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
    keymap.set("n", "<C-e>", function() harpoon:list():select(3) end)
    keymap.set("n", "<C-r>", function() harpoon:list():select(4) end)
  end,
}
