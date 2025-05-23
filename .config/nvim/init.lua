require('ume/basic_config')
require('ume/keymap')
require('ume/setup_plugin')
require('ume/plug_keymap')
vim.cmd('colorscheme iceberg')

-- icebergへの不満箇所
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#0f1117", fg = "#0f1117" })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#6A708B", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#6A708B", bg = "NONE" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- args.buf で対象のバッファ番号、args.data.client_id でクライアントIDが取れます
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- cpp ファイルかどうかチェック
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    if ft == "cpp" then
      -- このクライアントだけを停止
      vim.lsp.stop_client(client.id)
      -- (あるいは)vim.cmd("silent! LspStop")
      print("▶ cpp バッファなので LSP を停止しました: " .. client.name)
    end
  end,
})

-- windowセパレータを空白に設定したよ（一バイト文字しか読み込めない）
vim.opt.fillchars = { vert = ' ' }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "path/to/erb/folder/*.erb", -- 適切なフォルダパスを指定
    callback = function()
        vim.bo.filetype = "html"
    end,
})
