return {
  {
    "NeogitOrg/neogit",
    version = "v2.0.0", -- 安定バージョンを明示
    dependencies = {
      "nvim-lua/plenary.nvim",         -- 必須
      "sindrets/diffview.nvim",        -- オプション（おすすめ）
      "nvim-telescope/telescope.nvim", -- オプション
    },
    cmd = "Neogit", -- 起動コマンド
    config = function()
      -- 💡 カスタムハイライト（例：ヘッダー用）
      vim.api.nvim_set_hl(0, "MyNeogitHeader", {
        fg = "#4a90a4", bold = true,
      })

      require("neogit").setup({
        -- 👇 UIと動作の基本設定
        disable_commit_confirmation = false,
        disable_hint = false,
        use_magit_keybindings = true,
        kind = "split", -- or "tab", "floating"

        -- 👇 Git情報を表示するセクションの制御
        status = {
          recent_commit_count = 10, -- 履歴の表示件数
        },

        -- 👇 Diffview連携
        integrations = {
          diffview = true,
          telescope = true,
        },

        -- 👇 自動で開くセクション（例：staged/untrackedを開いておく）
        sections = {
          untracked = { folded = false },
          unstaged  = { folded = false },
          staged    = { folded = false },
          stashes   = { folded = true },
          unpulled  = { folded = true },
          recent    = { folded = true },
        },
      })

      -- 🚀 キーマップ追加
      vim.keymap.set("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
    end,
  }
}
