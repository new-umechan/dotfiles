return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"markdown", "tsx", "markdown_inline", "html",
				"javascript", "typescript", "c", "ruby", "lua"
			},
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})
	end,
}
