require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "html", "javascript", "typescript", "lua", "css" }, -- 必要な言語を追加
	highlight = {
		enable = true, -- シンタックスハイライトを有効化
	},
	indent = {
		enable = true -- スマートインデントを有効化
	},
	autotag = {
		enable = true, -- autotag機能を有効化
	}
}
