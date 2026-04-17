-- autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.erb",
    callback = function()
		vim.bo.filetype = "html.eruby"
    end,
})
