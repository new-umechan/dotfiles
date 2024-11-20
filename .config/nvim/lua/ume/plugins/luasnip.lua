return {
	"L3MON4D3/LuaSnip",
	event = 'InsertEnter',
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- cmpとの連携
		"rafamadriz/friendly-snippets", -- 汎用スニペット集
	},
	config = function()
		local luasnip = require("luasnip")

		-- カスタムスニペットのロード
		local custom_snippets_path = vim.fn.expand("~/.config/nvim/lua/ume/snippets/")
		if vim.fn.isdirectory(custom_snippets_path) == 1 then
			require("luasnip.loaders.from_lua").load({ paths = custom_snippets_path })
		else
			vim.notify("Custom snippets path does not exist: " .. custom_snippets_path, vim.log.levels.WARN)
		end

		-- FriendlySnippetsをロード
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
