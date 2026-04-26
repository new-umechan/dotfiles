local vault = vim.fn.expand("~/prog/markdown")

return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			frontmatter = { enabled = false },
			ui = { enable = false },
			legacy_commands = false,
			workspaces = {
				{
					name = "markdown",
					path = vault,
					strict = true,
				},
			},
		},
		keys = {
			{ "<leader>ko", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
		},
	},
}
