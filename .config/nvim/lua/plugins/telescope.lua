return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- telescope拡張
		{
			"danielfalk/smart-open.nvim",
			dependencies = {
				"kkharji/sqlite.lua",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "make",
				},
			},
		},
	},
	keys = {
		{ "<leader>kk", "<cmd>Telescope smart_open<cr>", desc = "Smart open" },
		{ "<leader>kf", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				smart_open = {
					cwd_only = true,
				},
			},
		})

		telescope.load_extension("smart_open")
	end,
}
