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
	-- カラースキーム
	{ "iceberg.vim", lazy = true, event = "VeryLazy" },

	-- ファイルツリー
	{
		"nvim-tree/nvim-tree.lua",
		  cmd = { "NvimTreeToggle", "NvimTreeFindFile" }, -- コマンド実行時にのみロード
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		},
		config = function()
			require("nvim-tree").setup()
		end,
	},

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

	-- treesitterを用いた行の結合
	{
		"Wansmer/treesj",
		keys = {
			{ "<space>m", "<cmd>TSJToggle<CR>", desc = "Toggle Treesitter Join/Split" }
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup()
		end,
	},

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

	-- snippetプラグイン
	{
		"L3MON4D3/LuaSnip",
		event = 'InsertEnter',
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- cmpとの連携
			"rafamadriz/friendly-snippets", -- 汎用スニペット集
		},
		config = function()
			local luasnip = require("luasnip")

			-- カスタムスニペットのロード
			local custom_snippets_path = vim.fn.expand("~/.config/nvim/lua/ume/snippets/")
			if vim.fn.isdirectory(custom_snippets_path) == 1 then
				require("luasnip.loaders.from_lua").load({
					paths = custom_snippets_path,
				})
			else
				vim.notify("Custom snippets path does not exist: " .. custom_snippets_path, vim.log.levels.WARN)
			end

			-- FriendlySnippetsをロード
			require("luasnip.loaders.from_vscode").lazy_load()
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

	-- surround
	{
		"kylechui/nvim-surround",
		lazy = true;
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- インクリメント・デクリメント
	{
		"monaqa/dial.nvim",
		lazy = true,
		config = function()
			require("ume.plugins.dial")
		end,
	},

	-- lazygit
	{ "kdheepak/lazygit.nvim" },

	-- gitsigns
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("ume.plugins.gitsigns").setup()
		end,
	},

	-- terminalをだす
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		config = function()
			require('toggleterm').setup({
				size = 20, -- サイズはフローティングウィンドウの場合は無視される
				direction = 'float', -- フローティングウィンドウを指定
				float_opts = {
					border = 'curved', -- ボーダーのスタイル（curved, double, single, shadow など）
				},
				shade_terminals = true, -- ターミナルの背景を暗くする
				start_in_insert = true, -- ターミナルを開いたら挿入モードでスタート
			})

			-- フローティングターミナル用のキーマッピング
			vim.keymap.set('n', '<space>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })
		end
	},

	-- flash
	 { import = "ume.plugins.flash" },

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
