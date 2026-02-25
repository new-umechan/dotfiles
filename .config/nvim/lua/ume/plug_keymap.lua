-- プラグイン系設定

-- keymaps Telesope
vim.api.nvim_set_keymap('n', '<leader>kk', "<cmd>Telescope smart_open<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kf', "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

-- <space>tでtermianlをとぐる
vim.keymap.set('n', '<space>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal' })

-- treesj
vim.keymap.set("n", "<leader>m", require("treesj").toggle, { desc = "Join Treesj" })

-- lazy
vim.keymap.set("n", "<space>r", ":OverseerRun<CR>1<CR><CR>", { desc = "quick run" })   -- sを無効化

-- gitsigns signのsと覚えよう
vim.keymap.set("n", "sj", ':Gitsigns next_hunk<CR>')
vim.keymap.set("n", "sk", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "sr", ":Gitsigns reset_hunk<CR>")

