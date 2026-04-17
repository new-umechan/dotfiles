return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_browserfunc = ""
			vim.g.mkdp_browser = "Arc"
			vim.g.mkdp_echo_preview_url = 1
		end,
	},
}
