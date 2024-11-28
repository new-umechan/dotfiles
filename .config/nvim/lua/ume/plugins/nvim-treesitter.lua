require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "html", "javascript", "typescript", "lua", "css", "ruby" }, -- 必要な言語を追加
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	}
}
