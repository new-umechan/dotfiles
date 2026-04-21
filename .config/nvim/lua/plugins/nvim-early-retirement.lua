return {
	{
		"chrisgrieser/nvim-early-retirement",
		event = "VeryLazy",
		opts = {
			retirementAgeMins = 5,
			ignoreFiletypes = {
				"qf",
				"gitcommit",
			},
		},
	},
}
