return {
	"Wansmer/treesj",
	keys = {
		{ "<space>m", "<cmd>TSJToggle<CR>", desc = "Toggle Treesitter Join/Split" }
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false, -- デフォルトのキーマップを無効化
		})
	end,
}
