return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_lsp = require("cmp_nvim_lsp")
		-- local util = vim.lsp.util -- (未使用のため削除してもOK)

		local capabilities = cmp_lsp.default_capabilities()
		-- ✨ 1. 競合解消: 位置エンコーディングをUTF-8に統一
		capabilities.textDocument.positionEncoding = { "utf-8" } 

		local on_attach = function(client, bufnr)
			local o = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, o)

			if client.name == "lua_ls" then
				-- 動作はしますが、on_init での設定が推奨
				client.config.settings.Lua.workspace.library = vim.list_extend(
					client.config.settings.Lua.workspace.library or {},
					vim.api.nvim_get_runtime_file("lua", true)
				)
			end
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = false,
			update_in_insert = false,
			severity_sort = true,
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "pyright", "ruff_lsp", "lua_ls" },
			handlers = {
				-- デフォルトハンドラー（Pyright, Ruff, Lua 以外）
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

                -- ✨ 2. Pyright 専用ハンドラー: 安定化と診断設定
                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            python = {
                                analysis = {
									venvPath = ".",
									venv = ".venv",
                                },
                            },
                        },
                    })
                end,

                -- Ruff LSP 専用ハンドラー
                ["ruff_lsp"] = function()
                    lspconfig.ruff_lsp.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
			},
		})
	end,
}
