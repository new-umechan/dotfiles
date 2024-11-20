return {
	'akinsho/toggleterm.nvim',
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	config = function()
		require('toggleterm').setup({
			size = 60,
			direction = 'vertical',
			-- floatとhorizontalもあるよ
			float_opts = {
				border = 'curved', -- ボーダーのスタイル（curved, double, single, shadow など）
			},
			shade_terminals = true, -- ターミナルの背景を暗くする
			start_in_insert = true, -- ターミナルを開いたら挿入モードでスタート
		})

		function _G.set_terminal_keymaps()
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts) -- 通常モードに戻る
		end

		vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
	end
}
