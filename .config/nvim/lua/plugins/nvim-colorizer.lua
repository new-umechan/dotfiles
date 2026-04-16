return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPost",
	config = function()
		require("colorizer").setup(
			{ "*" }, {
				names = false;
			}
		)
	end,
}
