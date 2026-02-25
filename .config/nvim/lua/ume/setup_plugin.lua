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

		{ import = "ume.plugins.iceberg" }, -- カラースキーム
		{ import = "ume.plugins.nvim-tree" }, -- ファイルツリー

		-- 基本依存プラグイン
		{ "nvim-lua/plenary.nvim" },

		-- 自動保存
		{ "pocco81/auto-save.nvim" },

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
			event = "bufreadpre",
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

		-- luasnip（先に読み込む）
		{ import = "ume.plugins.luasnip" },

		-- 補完プラグイン（lspより先に読み込む）
		{ import = "ume.plugins.nvim-cmp" },

		-- nvim-lspconfig（補完の後に読み込む）
		{ import = "ume.plugins.nvim-lspconfig" },

		-- 括弧自動補完
		{
			"windwp/nvim-autopairs",
			event = "insertenter",
			config = function()
				local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
				if not autopairs_ok then return end

				autopairs.setup()

				-- cmpとの連携（cmpが利用可能な場合のみ）
				local cmp_ok, cmp = pcall(require, 'cmp')
				local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

				if cmp_ok and cmp_autopairs_ok then
					cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
				end
			end,
		},

		-- treesitterの設定
		{
			"nvim-treesitter/nvim-treesitter",
			event = "bufreadpost",
			build = ":tsupdate", -- run → build に変更
			config = function()
				require("nvim-treesitter.configs").setup {
					ensure_installed = {
						"markdown", "tsx", "markdown_inline", "html",
						"javascript", "typescript", "c", "ruby", "lua"
					},
					highlight = { enable = true },
					indent = { enable = true },
					auto_install = true,
				}
			end,
		},

		{ import = "ume.plugins.treesj" },

		-- ts用のautotag
		{
			"windwp/nvim-ts-autotag",
			event = "insertenter",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("nvim-ts-autotag").setup({
					filetypes = {
						"html", "tsx", "javascript", "typescript", "typescriptreact",
						"xml", "vue", "svelte", "eruby"
					}
				})
			end,
		},

		-- コメントアウト
		{
			"numtostr/comment.nvim",
			event = { 'bufreadpost', 'bufnewfile' },
			dependencies = { "joosepalviste/nvim-ts-context-commentstring" },
			config = function()
				require("Comment").setup {
					pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				}
			end,
		},

		-- tsコンテキストコメント
		{
			"joosepalviste/nvim-ts-context-commentstring",
			event = { 'bufreadpost', 'bufnewfile' },
			dependencies = "nvim-treesitter/nvim-treesitter",
		},

		-- ファイルの高速実行
		{ import = "ume.plugins.overseer" },

		-- エラー表示 軽いらしいのでaleからnvim-linterに
		-- { import = "ume.plugins.nvim-lint" },

		-- fuzzy finder
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.5",
			dependencies = { "nvim-lua/plenary.nvim" },
		},

		-- telescope拡張
		{
			"danielfalk/smart-open.nvim",
			dependencies = {
				"kkharji/sqlite.lua",
				"nvim-telescope/telescope-fzf-native.nvim",
			},
		},

		-- カラーコードプレビュー
		{
			"norcalli/nvim-colorizer.lua",
			event = "bufreadpost",
			config = function()
				require("colorizer").setup({ "*" })
			end,
		},

		-- markdown設定
		{
			"ixru/nvim-markdown",
			ft = "markdown", -- ファイルタイプ固有で読み込み
			config = function()
				vim.g.vim_markdown_conceal = 1
				vim.g.vim_markdown_conceal_code_blocks = 1

				vim.api.nvim_create_autocmd("filetype", {
					pattern = "markdown",
					callback = function()
						vim.opt_local.conceallevel = 0
						vim.opt_local.concealcursor = "nc"
					end
				})
			end,
		},

		-- 編集強化
		{ import = "ume.plugins.surround" },

		-- dial.nvim（数値のインクリメント・デクリメント強化）
		{ import = "ume.plugins.dial" },

		-- ワープ
		{ import = "ume.plugins.flash" },

		-- git（gitsignsの問題を回避するため直接設定）
		{
			"lewis6991/gitsigns.nvim",
			event = { "bufreadpre", "bufnewfile" },
			config = function()
				local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
				if not gitsigns_ok then return end

				gitsigns.setup({
					signs = {
						add = { text = '+' },
						change = { text = '~' },
						delete = { text = '_' },
						topdelete = { text = '‾' },
						changedelete = { text = '~' },
					},
				})
			end,
		},

		{ import = "ume.plugins.lazygit" },

		-- terminalをだす
		{ import = "ume.plugins.toggleterm" },

		-- バイナリ表示
		{ import = "ume.plugins.hex_nvim" },

		-- htmlのpreview
		{ import = "ume.plugins.live-preview" },

		-- aiをやる
		{ import = "ume.plugins.opencode" },

		-- jupytor notebook的な感じに
		{ import = "ume.plugins.iron" }
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
