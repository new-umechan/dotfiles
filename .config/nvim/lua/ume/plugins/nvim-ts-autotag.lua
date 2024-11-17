require('nvim-treesitter.configs').setup {
  -- 他の設定は省略
  autotag = {
    enable = true,
    filetypes = { "html", "typescriptreact", "javascriptreact" }  -- TSX, JSX, HTMLでのみ有効化
  },
}
