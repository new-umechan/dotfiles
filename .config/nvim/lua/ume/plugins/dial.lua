-- lua/ume/plugins/dial.lua
return {
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>",  function() require("dial.map").manipulate("increment","normal") end,  desc = "Dial +1" },
			{ "<C-x>",  function() require("dial.map").manipulate("decrement","normal") end,  desc = "Dial -1" },
			{ "<C-a>",  function() require("dial.map").manipulate("increment","visual") end,  mode = "v" },
			{ "<C-x>",  function() require("dial.map").manipulate("decrement","visual") end,  mode = "v" },

		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.constant.alias.bool,
				},
			})
		end,
	},
}
