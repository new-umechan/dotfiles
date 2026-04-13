return {
    name = "gcc build and run in terminal",
    builder = function()
        local file = vim.fn.expand("%:p")
        local quoted_file = vim.fn.shellescape(file)

        return {
            cmd = { "zsh" },
            args = {
                "-c",
                string.format("gcc %s -o ./a.out && ./a.out", quoted_file),
            },
            components = {
                "default",
            },
            strategy = {
                "toggleterm",
                direction = "vertical",
                close_on_exit = false,
                open_on_start = true,
                auto_scroll = true,
            },
        }
    end,
    condition = {
        filetype = { "c" },
    },
}
