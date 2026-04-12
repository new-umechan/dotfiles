return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require'nvim-tree'.setup {
			view = {
				width = 30,
				side = 'left',
			},

			renderer = {
				highlight_opened_files = "all",
			},

			hijack_cursor = false,
			update_focused_file = {
				enable      = true,
				update_cwd  = true,
			},

			trash = {
				cmd = "trash",  -- 使用するゴミ箱コマンド
			},

			ui = {
				confirm = {
					remove = true,
					trash = true,
					default_yes = false,
				},
			},

			git = {
				ignore = false,
			},

			actions = {
				open_file = {
					resize_window = true, -- ファイルを開くときにウィンドウを自動リサイズ
				},
			},
			on_attach = function(bufnr)
				local api = require('nvim-tree.api')
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set('n', 't', api.fs.create, opts('Create'))
				vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
				vim.keymap.set('n', 'y', api.fs.copy.node, opts('Yank'))
				vim.keymap.set('n', 'p', api.fs.paste, opts('Paste Node'))
				vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
				vim.keymap.set('n', 'f', api.node.open.edit, opts('Open Node'))
				vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open in Vertical Split'))  -- 垂直分割

			end,
			hijack_netrw = true, -- netrwを乗っ取って、nvim-treeを使う
		}

		-- 見た目の速さを出すためにコメントアウト

		-- デフォルトでnvim-treeを開く設定
		-- vim.api.nvim_create_autocmd({"VimEnter"}, {
		-- 	callback = function()
		-- 		require("nvim-tree.api").tree.open()
		-- 	end
		-- })
		--
	end,
}
