return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false;
		ft = { "markdown", "quarto", "Avante" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-mini/mini.icons",
		},
		opts = {
			render_modes = { "n", "c", "t" },
			code = { enabled = false },
			heading = { enabled = false },
			pipe_table = { enabled = false },
			anti_conceal = { enabled = false },
			dash = { enabled = false },
			bullet = { enabled = false },

			checkbox = {
				enabled = true,
				bullet = false,
				left_pad = 0,
				right_pad = 1,
				unchecked = {
					icon = "󰄱 ",
					highlight = "RenderMarkdownUnchecked",
				},
				checked = {
					icon = "󰱒 ",
					highlight = "RenderMarkdownChecked",
				},
			},


			win_options = {
				concealcursor = {
					rendered = "n",
				},
				conceallevel = {
					rendered = 0,
				},
			},
		},

		config = function(_, opts)
			require("render-markdown").setup(opts)
		end,
	},
}
