require("mason-lspconfig").setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup{}
    end,
    ["ts_ls"] = function()
        require('lspconfig').ts_ls.setup{}
    end,
    ["clangd"] = function()
        require('lspconfig').clangd.setup{}
    end,
    ["jdtls"] = function()
        require('lspconfig').jdtls.setup{}
    end,
}
