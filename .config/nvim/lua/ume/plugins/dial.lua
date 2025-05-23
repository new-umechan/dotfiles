local augend = require("dial.augend")

return {
	"monaqa/dial.nvim",
	lazy = true,
	config = function()
		require("dial.config").augends:register_group{
			default = {
				augend.integer.alias.decimal,  -- 数値の増減
				augend.constant.new{
					elements = {"true", "false"},
					cyclic = true,  -- `true`と`false`が循環して切り替わる
				},
			}
		}
	end,
}
