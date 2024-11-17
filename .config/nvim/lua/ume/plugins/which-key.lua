-- 休止中
local M = {}

function M.setup()
    local wk = require("which-key")

    -- which-key の基本セットアップ
    wk.setup({
        triggers = {},      -- トリガーを無効化
        show_keys = false,  -- キーバインドを表示しない
        disable = {
            buftypes = {},  -- 無効化するバッファタイプ
            filetypes = {}, -- 無効化するファイルタイプ
        },
    })

    wk.register({
        ["<leader>kk"] = { "<cmd>Telescope find_files<cr>", "ファイルを探す" },
    }, { mode = "n" })  -- ノーマルモードに適用
end

return M
