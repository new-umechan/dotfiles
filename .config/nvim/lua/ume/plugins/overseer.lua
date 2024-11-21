return {
	'stevearc/overseer.nvim',
	opts = {
		templates = { "builtin", "c_runner" },
		strategy = {
			"toggleterm",
			quit_on_exit = "never",
		},
	}
}
