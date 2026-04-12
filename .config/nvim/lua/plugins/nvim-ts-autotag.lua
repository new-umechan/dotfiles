return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-ts-autotag").setup({
			filetypes = {
				"html", "tsx", "javascript", "typescript", "typescriptreact",
				"xml", "vue", "svelte", "eruby"
			}
		})
	end,
}
