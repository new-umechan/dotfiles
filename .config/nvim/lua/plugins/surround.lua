return {
	"kylechui/nvim-surround",
	lazy = true;
	event = "BufReadPost", -- ファイルを読み込んだときに実行
	config = function()
		require("nvim-surround").setup({
			--emptyでデフォルトキーマップ
		})
	end,
}
