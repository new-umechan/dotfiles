return {
    name = "python runner",
    builder = function()
        local file = vim.fn.expand("%:p")
        local quoted_file = vim.fn.shellescape(file)

        local function is_uv_project()
            return vim.fn.filereadable("pyproject.toml") == 1
        end

        local cmd
        if vim.fn.executable("uv") == 1 and is_uv_project() then
            cmd = string.format("uv run %s", quoted_file)
        else
            cmd = string.format("python %s", quoted_file)
        end

        return {
            cmd = { "zsh" },
            args = { "-c", cmd },
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
        filetype = { "python" },
    },
}
