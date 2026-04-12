return {
	-- tsコンテキストコメント
	{
		"joosepalviste/nvim-ts-context-commentstring",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	-- コメントアウト
	{
		"numtostr/comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "joosepalviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
