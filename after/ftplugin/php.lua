-- This executes ONLY when a PHP file is opened
-- Forces Neovim to ignore Tree-sitter matching rules and use native PHP indenting
vim.b.did_indent = 1

-- 2. Use Neovim's Treesitter engine for PHP indentation
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- 3. Standard fallback indentation safety nets
vim.bo.autoindent = true
vim.bo.smartindent = false -- smartindent clashes with PHP and should be false
