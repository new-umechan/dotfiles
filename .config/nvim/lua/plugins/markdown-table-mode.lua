return {
	"Kicamon/markdown-table-mode.nvim",
	ft = "markdown",
	config = function()
		require('markdown-table-mode').setup({
			options = {
				insert = true, -- when typing "|"
				insert_leave = true, -- when leaving insert
				pad_separator_line = true, -- add space in separator line
				align_style = 'default', -- default, left, center, right
			},
		})
	end,
}
