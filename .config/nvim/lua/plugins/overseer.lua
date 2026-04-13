return {
    "stevearc/overseer.nvim",
    keys = {
        {
            "<space>r",
            function()
                local ft = vim.bo.filetype
                local name_by_ft = {
                    c = "gcc build and run in terminal",
                    python = "python runner",
                }
                local name = name_by_ft[ft]
                if name then
                    require("overseer").run_task({ name = name })
                    return
                end
                vim.cmd("OverseerRun")
            end,
            desc = "Quick run",
        },
    },
    opts = {
        templates = { "builtin", "c", "python" },
    },
}
