-- neovimのもともとの機能を消す
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
	{ import = "ume.plugins.iceberg"}, -- カラースキーム
	{ import = "ume.plugins.nvim-tree"}, --	 ファイルツリー
	-- 基本依存プラグイン
	{ "nvim-lua/plenary.nvim" },
	-- 自動保存
	{ "pocco81/auto-save.nvim" },

	-- masonの追加
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" }, -- コマンド実行時に読み込む
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre"
	},

	-- LSPサーバーの設定
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre" }, -- 遅延ロード
		config = function()
			require('mason').setup()
			require('mason-lspconfig').setup_handlers({
				function(server)
					local opt = {
						capabilities = require('cmp_nvim_lsp').default_capabilities(
							vim.lsp.protocol.make_client_capabilities()
						)
					}
					require('lspconfig')[server].setup(opt)
				end
			})
		end
	},

	-- 括弧自動補完
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function() require("nvim-autopairs").setup() end,
	},

	-- treesitterの設定
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost", -- ファイルを開いたときに読み込む
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "markdown", "markdown_inline", "html", "javascript", "typescript", "c" },
				highlight = { enable = true },
				indent = { enable = true },
			}
		end,
	},

	{ import = "ume.plugins.treesj"},	-- 行の結合

	-- ts用のautotag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "javascriptreact", "typescriptreact" }, -- 必要なファイルタイプだけ
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = { "html", "javascript", "typescript", "xml", "vue", "svelte" }
			})
		end,
	},

	-- コメントアウト
	{
		"numToStr/Comment.nvim",
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			require("Comment").setup {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},

	-- tsコンテキストコメント
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { 'BufReadPost', 'BufNewFile' },
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- ファイルの高速実行
	{ "thinca/vim-quickrun" },

	-- エラー表示
	{ "dense-analysis/ale", config = function() require('ume.plugins.ale') end },

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
	},

	-- telescope速く
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make", -- 初回インストール時にCコードをビルドする
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	-- telescope拡張　いろんな要素を考慮してfuzzyFindしてくれる
	{
		"danielfalk/smart-open.nvim",
		dependencies = {
			"kkharji/sqlite.lua", -- Frecencyデータの保存用
			"nvim-telescope/telescope-fzf-native.nvim", -- 高速なFZFサポート
		},
	},

	-- カラーコードプレビュー
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost", -- ファイルを開いた後に自動ロード
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},

	-- Markdown設定
	{
		"ixru/nvim-markdown",
		config = function()
			-- プラグイン固有の設定
			vim.g.vim_markdown_conceal = 1
			vim.g.vim_markdown_conceal_code_blocks = 1

			-- FileType autocmd
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.conceallevel = 0
					vim.opt_local.concealcursor = "nc"
				end
			})
		end,
	},

	-- 補完
	-- https://qiita.com/delphinus/items/fb905e452b2de72f1a0f#441-hrsh7thnvim-cmpを参考
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" }, -- 挿入モードとコマンドラインモードで遅延読み込み
		dependencies = {
			-- LSP用補完ソース
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			-- バッファ補完ソース
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			-- パス補完ソース
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			-- コマンドライン補完ソース
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			-- LuaSnip用補完ソース
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
		},
		config = function()
			require("ume.plugins.nvim-cmp") -- 設定ファイルを呼び出す
		end,
	},

	-- 編集強化
	{ import = "ume.plugins.surround"},	-- かっこ編集
	{ import = "ume.plugins.dial"},	-- インクリメント、デクリメント強化
	{ import = "ume.plugins.flash" }, 	-- Jump系プラグイン 使いこなせたらとてつもなく便利そう
	{ import = "ume.plugins.luasnip"},	-- snipet

	-- git
	{ "kdheepak/lazygit.nvim" }, -- nvim上git tui操作
	{ import = "ume.plugins.gitsigns"},	-- 右側にgitの差分が出る

	-- terminalをだす
	{ import = "ume.plugins.toggleterm"},

}, {

	ui = {
		border = "rounded", -- ボーダースタイルを指定（rounded, single, double, solid, shadowなど）
		colors = {
			background = "#161822", -- Icebergのダーク背景色
			border = "#6b7089", -- ボーダー色（淡いグレー）
			title = "#d2d4de", -- タイトルテキストの色（明るいグレー）
			normal = "#c6c8d1", -- 通常のテキスト色（明るいグレー）
			comment = "#6b7089", -- コメント色（落ち着いたグレー）
			error = "#e27878", -- エラーテキストの色（赤みのある色）
		},
	},
	-- 起動速度を早くするための確認用
	-- :Lazy profileでわかる
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
				"netrwPlugin",
				"tutor",
				"matchit", -- 使っていなければ無効化
				"matchparen", -- 使っていなければ無効化
			},
		},
	},
	debug = false, -- デバッグ情報 いちいちうるさいので、テスト中のみの適用をおすすめ
	profiler = true, -- プロファイラーを有効化
})
