-- keymap

vim.g.mapleader = ' ' -- leaderキー
-- スペースキーを無効化
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>', { silent = true })

-- 移動を楽に
-- vim.keymap.set({ 'n', 'v' }, 'K', '10k', { noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'v' }, 'J', '10j', { noremap = true, silent = true })

-- 上の埋め合わせ
-- vim.keymap.set('n', '<C-J>', 'J', { noremap = true, silent = true })

-- Emacs風のキーバインド
vim.keymap.set({ 'i', 'c' }, '<C-p>', '<Up>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-h>', '<BS>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>', { noremap = true, silent = true })

-- Uキーでredo （もとはその行の編集を止めてた）
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true, silent = true })

-- 右のfiletreeの表示/非表示
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<cr>', { silent = true })

-- コピペの簡略化
vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true, silent = true })

-- ペーストが便利かも
vim.api.nvim_set_keymap('n', 'p', ']p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'P', ']P', { noremap = true, silent = true })

-- その他便利設定
vim.keymap.set('i', 'jj', '<esc>', { silent = true }) -- インサートモードを抜ける

-- 検索結果を消す
vim.api.nvim_set_keymap('n', '<leader>c', ':nohlsearch<CR>', { noremap = true, silent = true })

-- 画面遷移
vim.keymap.set({ 'n', 'v' }, '<leader>f', '<c-w>w')

-- 相対行表示をon/off
-- lazyのon offのキーとかぶっちゃったのでやめた
-- vim.api.nvim_set_keymap('n', '<leader>l', ":set relativenumber!<cr>", {})


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
-- 上二つはあんまつかわん
vim.keymap.set("n", "<leader>j", require("treesj").join, { desc = "Toggle Treesj" })
vim.keymap.set("n", "<leader>s", require("treesj").split, { desc = "Split Treesj" })
vim.keymap.set("n", "<leader>m", require("treesj").toggle, { desc = "Join Treesj" })

-- lazy
vim.keymap.set('n', '<space>ll', ':Lazy<CR>', { noremap = true, silent = true})
vim.keymap.set('n', '<space>lp', ':Lazy profile<CR>', { noremap = true, silent = true})

-- terminalを出す
vim.keymap.set('n', '<space>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })
