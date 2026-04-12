-- autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "path/to/erb/folder/*.erb",
    callback = function()
        vim.bo.filetype = "html"
    end,
})
