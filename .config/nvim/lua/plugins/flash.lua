-- lua/plugins/flash.lua
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				enabled = false, -- これでfやtの拡張を無効化
			},
		},
	},
	keys = {
		{ "+", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
