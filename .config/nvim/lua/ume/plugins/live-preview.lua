-- lua/ume/plugins/bracery.lua
return {
  "brianhuster/live-preview.nvim",
  cmd = { "LivePreview", "LivePreviewStop" },
  ft = { "html", "css", "javascript" },
  config = function()
	require("live-preview").setup({
	  port = 3000,          -- プレビュー用のポート番号
	  browser = "default",  -- 既定ブラウザを使用
	  start_command = "npx browser-sync start --server --files '**/*.{html,css,js}' --port 3000",
	  stop_command = nil,   -- デフォルトで止める
	  open = true,          -- 起動時にブラウザ開く
	})

	-- キーマップ例
	vim.keymap.set("n", "<leader>lp", "<cmd>LivePreview start<CR>", { desc = "Start Live Preview" })
	vim.keymap.set("n", "<leader>lP", "<cmd>LivePreviewStop<CR>", { desc = "Stop Live Preview" })
  end,
}
