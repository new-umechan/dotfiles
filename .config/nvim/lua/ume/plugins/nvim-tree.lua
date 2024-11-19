local M = {}

M.setup = function()

	require'nvim-tree'.setup {
		view = {
			width = 30,
			side = 'left',
		},

		renderer = {
			highlight_opened_files = "all",
		},

		hijack_cursor = false, -- カーソルをツリーに移動
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

			-- Default mappings. Feel free to modify or remove as needed.
			vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
			vim.keymap.set('n', 't', api.fs.create, opts('Create'))
			vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
			vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
			vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
			vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open in Vertical Split'))  -- 垂直分割

		end,
		open_on_tab = true, -- タブで開いたときにファイルツリーを表示
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
end

return M
