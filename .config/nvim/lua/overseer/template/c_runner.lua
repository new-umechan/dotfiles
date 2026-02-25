--lua/overseer/template/c_runner.lua
return {
	name = "gcc build and run in terminal",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "zsh" },
			args = {
				"-c",
				string.format("gcc %s -o ./a.out && ./a.out", file),
			},
			components = {
				"default",
			},
			strategy = {
				"toggleterm",
				-- これtrueにすると、コマンドに変な文字exit $?がうたれる
				use_shell = false,
				direction = "vertical",
				close_on_exit = false,
				open_on_start = true,
				auto_scroll = true,
			},
		}
	end,
	condition = {
		filetype = { "c" },
	},
}
