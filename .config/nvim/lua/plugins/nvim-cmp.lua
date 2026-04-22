return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = false,
	dependencies = {
		{ "L3MON4D3/LuaSnip" }, -- スニペットエンジン LuaSnip
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip/loaders/from_vscode").lazy_load()

		local markdown_wikilink = {}
		markdown_wikilink.new = function()
			return setmetatable({}, { __index = markdown_wikilink })
		end

		function markdown_wikilink:is_available()
			local ft = vim.bo.filetype
			return ft:match("^markdown") ~= nil or ft == "mdx" or ft == "quarto" or ft == "vimwiki"
		end

		function markdown_wikilink:get_debug_name()
			return "markdown_wikilink"
		end

		function markdown_wikilink:get_keyword_pattern()
			return [[\%(\k\|/\|\.\|-\)\+]]
		end

		function markdown_wikilink:complete(params, callback)
			local target = params.context.cursor_before_line:match("%[%[([^%[%]|#]*)$")
			if not target then
				callback({ items = {} })
				return
			end
			if target == "" then
				callback({ items = {}, isIncomplete = true })
				return
			end

			local items = {}
			local seen = {}
			local pattern = target:find("/", 1, true) and target or ("*%s*"):format(target)

			for _, candidate in ipairs(vim.fn.getcompletion(pattern, "file")) do
				if not seen[candidate] then
					seen[candidate] = true
					local basename = vim.fn.fnamemodify(candidate, ":t")
					local stem = basename:gsub("%.md$", "")
					local alias = stem:gsub("^%d%d%d%d%d%d_", "")
					local label = alias ~= stem and alias or candidate
					items[#items + 1] = {
						label = label,
						word = label,
						insertText = candidate,
						filterText = label,
						detail = label == candidate and nil or candidate,
					}
				end
			end

			callback({ items = items, isIncomplete = false })
		end

		cmp.register_source("markdown_wikilink", markdown_wikilink.new())

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"]   = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"]    = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "markdown_wikilink" },
				{ name = "luasnip" },
			}, {
					{ name = "buffer" },
					{ name = "path" },
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
