return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup()

		-- html/typescriptでは無効化
		vim.cmd([[
		  autocmd FileType html,typescript lua require('nvim-autopairs').disable()
		]])

		-- cmpとの連携（cmpが利用可能な場合のみ）
		local cmp_ok, cmp = pcall(require, 'cmp')
		local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

		if cmp_ok and cmp_autopairs_ok then
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end
	end,
}
