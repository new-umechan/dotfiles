return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_lsp.default_capabilities()
		capabilities.textDocument.positionEncoding = { "utf-8" }

		local on_attach = function(client, bufnr)
			local o = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, o)

			if client.name == "lua_ls" then
				client.config.settings.Lua.workspace = client.config.settings.Lua.workspace or {}
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
			ensure_installed = { "pyright", "ruff", "lua_ls" },
			automatic_enable = false,
		})

		vim.lsp.config("pyright", {
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

		vim.lsp.config("ruff", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.lsp.enable("pyright")
		vim.lsp.enable("ruff")
		vim.lsp.enable("lua_ls")
	end,
}
