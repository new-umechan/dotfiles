return {
	"pocco81/auto-save.nvim",
	opts = {
		trigger_events = { "InsertLeave", "BufLeave", "FocusLost" },
		condition = function(buf)
			local ft = vim.bo[buf].filetype
			local bt = vim.bo[buf].buftype

			if ft == "fyler" then
				return false
			end

			if bt ~= "" then
				return false
			end

			return true
		end,
	},
}
