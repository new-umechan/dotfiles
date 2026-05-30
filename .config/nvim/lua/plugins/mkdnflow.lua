return {
    {
        "jakewvincent/mkdnflow.nvim",
        ft = { "markdown", "rmd" },
        opts = {
            modules = {
                maps = false,
                folds = false,
                foldtext = false,
                yaml = false,
            },
            wrap = false,
            filetypes = {
                markdown = true,
                rmd = true,
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    "n",
                    "<leader>mt",
                    "<Cmd>MkdnTableFormat<CR>",
                    {
                        buffer = bufnr,
                        silent = true,
                        desc = "Format markdown table",
                    }
                )
            end,
        },
    },
}
