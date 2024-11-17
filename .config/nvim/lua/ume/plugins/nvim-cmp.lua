local cmp = require('cmp')

-- GPTなのでどうなっているか全くわからん

-- LuaSnipをインポート
local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
    vim.notify("LuaSnip could not be loaded", vim.log.levels.ERROR)
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
			luasnip.lsp_expand(args.body)  -- LuaSnipでスニペットを展開
        end,
    },
	window = {
        completion = cmp.config.window.bordered(), -- 補完ウィンドウに枠線を追加
        documentation = cmp.config.window.bordered(), -- ドキュメントウィンドウに枠線を追加
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enterで補完を確定
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', max_item_count = 5 }, -- nvim_lspのアイテム数を制限
		{ name = 'luasnip' },  -- LuaSnipのスニペットを補完候補に追加
        { name = 'buffer', max_item_count = 15 },   -- bufferのアイテム数を制限
        { name = 'path', max_item_count = 15 }      -- pathのアイテム数を制限
    }),
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- `:`の補完設定
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

