return {
	'akinsho/toggleterm.nvim',
	version = "*",
	cmd = { "ToggleTerm", "TermExec" }, -- 遅延ロード
	config = function()
		require('toggleterm').setup({
			size = 15,
			direction = 'horizontal', -- 水平表示
			shade_terminals = true,
			start_in_insert = true,
		})

		-- ターミナルモード専用のキーマッピング
		function _G.set_terminal_keymaps()
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', [[<C-\><C-n>:ToggleTerm<CR>]], opts) -- ターミナルを閉じる
			vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts) -- 通常モードに戻る
		end

		vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
	end,
}
