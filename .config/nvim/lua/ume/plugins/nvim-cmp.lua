return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = false,
	dependencies = {
		{ "saadparwaiz1/cmp_luasnip" }, -- LuaSnip と nvim-cmp を統合
		{ "L3MON4D3/LuaSnip" }, -- スニペットエンジン LuaSnip
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip/loaders/from_vscode").lazy_load()

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"]   = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"]    = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				-- { name = "nvim_lsp", max_item_count = 5 },
				{ name = "luasnip", priority_weight = 15 },
			}, {
				{ name = "buffer", priority_weight = 15 },
				{ name = "path",   priority_weight = 15 },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		})
	end,
}
