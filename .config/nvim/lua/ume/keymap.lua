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

