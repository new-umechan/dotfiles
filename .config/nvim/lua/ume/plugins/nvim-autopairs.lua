require('nvim-autopairs').setup({
	vim.cmd([[
	  autocmd FileType html,typescript lua require('nvim-autopairs').disable()
	]])
})
