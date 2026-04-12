return {
	'RaafatTurki/hex.nvim',
	event = 'BufReadPost',  -- ファイル読み込み後に動的ロード
	config = function()
		require('hex').setup{}

		vim.api.nvim_set_keymap('n', '<leader>h',
			':HexToggle<CR>', { noremap=true, silent=true })

		vim.api.nvim_create_autocmd('BufReadPost', {
			callback = function(args)
				-- &binary が true のときだけ HexToggle
				if vim.bo[args.buf].binary then
					vim.cmd('HexToggle')
				end
			end,
		})
	end,
}
