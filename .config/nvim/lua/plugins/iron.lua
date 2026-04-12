return {
	'Vigemus/iron.nvim',
	-- Ironを起動するためのコマンドをロード時に利用可能にする
	cmd = {
		'IronRepl',
		'IronSend',
		'IronFocus',
		'IronClear',
		'IronRestart',
	},
	-- Ironが特定のファイルタイプで自動的にREPLを起動するように設定
	ft = {
		'python',
		'r',
		'julia',
		'haskell',
		'clojure',
		'go',
		'typescript',
		'javascript',
		'ruby',
		'sh',
	},
	-- 必要に応じて設定をカスタマイズ
	config = function()
		require('iron.core').setup({
			-- ここにIronのカスタマイズ設定を記述します。
			-- 例:
			-- repl_definition = {
			--   python = {
			--     command = 'ipython', -- ipythonを使いたい場合
			--   },
			--   -- 他の言語の設定も追加
			-- },
			-- keymaps = {
			--   send_motion = '<leader>ss',
			--   send_file = '<leader>sf',
			--   send_line = '<leader>sl',
			--   send_visual = '<leader>sv',
			--   -- その他
			-- },
		})
	end,
	-- 依存関係 (もしあれば。iron.nvimは通常、外部依存はありませんが、
	-- REPLウィンドウを管理するために'toggleterm.nvim'などと組み合わされることがあります)
	-- dependencies = {
	--   'akinsho/toggleterm.nvim',
	-- },
}
