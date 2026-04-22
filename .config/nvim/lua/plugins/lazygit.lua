return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>g",
			function()
				local name = vim.api.nvim_buf_get_name(0)

				-- Fyler バッファなら URI を実パスに戻して、その場所で LazyGit
				if name:match("^fyler://") then
					local dir = name:gsub("^fyler://", "")

					local cwd = vim.fn.getcwd()
					vim.cmd("silent cd " .. vim.fn.fnameescape(dir))
					vim.cmd("LazyGit")
					vim.cmd("silent cd " .. vim.fn.fnameescape(cwd))
				else
					vim.cmd("LazyGitCurrentFile")
				end
			end,
			desc = "LazyGit",
		},
	},
}
