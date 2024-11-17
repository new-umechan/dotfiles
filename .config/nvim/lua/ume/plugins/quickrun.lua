-- QuickRunの基本設定
vim.g.quickrun_config = {
	_ = {
		runner = 'terminal',
		outputter = 'terminal',
		['outputter/terminal/opener'] = 'botright 10split',
		['outputter/terminal/quit_on_exit'] = 0,
	},

	-- C言語用の設定
	c = {
		command = 'gcc',
		cmdopt = '-std=c11 -Wall',
		exec = 'zsh -c "%c %o %s -o %s:p:r && %s:p:r"',
		tempfile = '%{tempname()}.c',
		['hook/sweep/files'] = { '%S:p:r' },
	},

	-- Java用の設定
	java = {
		command = 'javac',
		cmdopt = '-encoding UTF-8 -Xlint',
		exec = 'zsh -c "%c %o %s && java -cp %S:p:h %S:p:t:r"',
		tempfile = '%{tempname()}.java',
		['hook/sweep/files'] = { '%S:p:r.class' },
	},
}
