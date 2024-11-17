-- Comment.nvimの設定
local M = {}

M.setup = function()
  require('Comment').setup({
    -- コメント機能のカスタマイズ
    toggler = {
      line = 'gcc',  -- 行単位コメント
      block = 'gbc', -- ブロック単位コメント
    },
    opleader = {
      line = 'gc',   -- ノーマルモードで行単位コメント
      block = 'gb',  -- ブロックコメント
    },
    mappings = {
      basic = true,  -- 基本的なマッピングを有効
      extra = false, -- 追加マッピングを無効
    },
  })
end

return M
