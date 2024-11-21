-- プラグイン系設定

-- keymaps Telesope
vim.api.nvim_set_keymap('n', '<leader>kk', "<cmd>Telescope smart_open<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>km', "<cmd>Telescope keymaps<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kf', "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kh', "<cmd>Telescope command_history<cr>", { noremap = true, silent = true })

-- dial.nvimを既存のインクリメント、デクリメントを上書き
local dial = require("dial.map")
vim.api.nvim_set_keymap("n", "<C-a>", dial.inc_normal(), { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", dial.dec_normal(), { noremap = true, silent = true })

-- lazygit呼び出し
vim.api.nvim_set_keymap('n', '<leader>g', ':LazyGit<CR>', { noremap = true, silent = true })

-- <space>tでtermianlをとぐる
vim.keymap.set('n', '<space>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal' })

-- treesj
vim.keymap.set("n", "<leader>m", require("treesj").toggle, { desc = "Join Treesj" })

-- lazy
vim.keymap.set('n', '<space>ll', ':Lazy<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<space>lp', ':Lazy profile<CR>', { noremap = true, silent = true})

-- terminalを出す
vim.keymap.set('n', '<space>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })

-- surroundのため
vim.keymap.set({ "n", "x" }, "s", "<nop>", { desc = "Disable default s" }) -- sを無効化

vim.keymap.set( "n" , "<space>r", ":OverseerRun<CR>1<CR><CR>", { desc = "quick run" }) -- sを無効化
