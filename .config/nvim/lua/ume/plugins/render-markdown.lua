return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "quarto", "Avante" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-mini/mini.icons",
		},
		opts = {
			render_modes = { "n", "c", "t" },

			anti_conceal = {
				enabled = false,
			},

			heading = {
				enabled = false,
			},

			pipe_table = {
				enabled = false,
			},

			code = {
				enabled = false,
			},

			inline_code = {
				enabled = false,
			},

			bullet = {
				enabled = false,
			},

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

			quote = {
				enabled = false,
			},

			win_options = {
				concealcursor = {
					rendered = "n",
					raw = "n",
				},
				conceallevel = {
					rendered = 2,
					raw = 0,
				},
			},
		},

		config = function(_, opts)
			require("render-markdown").setup(opts)

			local set_hl = vim.api.nvim_set_hl
			set_hl(0, "RenderMarkdownBullet", { link = "Comment" })
		end,
	},
}
