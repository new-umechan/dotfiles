return {
	{
		"A7Lavinraj/fyler.nvim",
		branch = "stable",
		lazy = false,
		enabled = false;
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			integrations = {
				icon = "nvim_web_devicons",
			},

			-- 今開いてるファイルへ追従したいなら有効
			follow_current_file = true,

			-- 監視
			watcher = {
				enabled = true,
			},
		},
		config = function(_, opts)
			local fyler = require("fyler")
			fyler.setup(opts)

			vim.keymap.set("n", "<leader>e", "<cmd>Fyler<CR>", { desc = "Open Fyler View" })
		end,
	},
}
