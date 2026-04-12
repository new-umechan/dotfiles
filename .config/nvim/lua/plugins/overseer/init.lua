-- overseer pluginの設定
return {
	'stevearc/overseer.nvim',
	keys = {
		{ "<space>r", function()
			vim.cmd("OverseerRun")
			vim.fn.feedkeys("1\\<CR>\\<CR>")
		end, desc = "Quick run" },
	},
	opts = {
		templates = { "builtin", "c", "python" },
		template_dirs = {
			vim.fn.stdpath("config") .. "/lua/plugins/overseer/templates",
		},
		strategy = {
			"toggleterm",
			quit_on_exit = "never",
		},
	},
}
