-- neovimのもともとの機能を消す
vim.g.loaded_netrw = 1
vim.g.loaded_netrwplugin = 1

-- lazy.nvimのインストールコード
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {

		-- plugins/ 以下の全プラグインをimport
		{ import = "plugins" },

		-- plugins/overseer/ 以下の設定をimport
		{ import = "plugins.overseer" },

		-- mason（先に初期化）
		{
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUpdate" },
			config = function()
				require("mason").setup()
			end,
		},

		-- mason-lspconfig
		{
			"williamboman/mason-lspconfig.nvim",
			event = "BufReadPre",
			dependencies = { "williamboman/mason.nvim" },
			config = function()
				local ok, mlsp = pcall(require, "mason-lspconfig")
				if not ok then return end
				pcall(mlsp.setup, {
					ensure_installed = { "lua_ls", "html", "cssls", "clangd", "pyright", "solargraph", "ruff" },
					automatic_installation = false,
				})
			end,
		},

	},
}, {
		ui = {
			border = "rounded",
			colors = {
				background = "#161822",
				border = "#6b7089",
				title = "#d2d4de",
				normal = "#c6c8d1",
				comment = "#6b7089",
				error = "#e27878",
			},
			notifications = {
				enabled = false,
			},
		},
		git = { url_format = "git@github.com:%s.git" },
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"tarplugin",
					"tohtml",
					"zipplugin",
					"netrwplugin",
				},
			},
		},
		debug = false,
	})
