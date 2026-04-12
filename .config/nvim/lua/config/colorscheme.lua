vim.cmd('colorscheme iceberg')

-- icebergへの不満箇所
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#0f1117", fg = "#0f1117" })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#6A708B", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#6A708B", bg = "NONE" })

vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#84a0c6", bg = "NONE" })
vim.api.nvim_set_hl(0, "RenderMarkdownChecked",   { fg = "#6b7089", bg = "NONE" })

vim.api.nvim_set_hl(0, "@markup.raw", { fg = "#89b8c2", bg = "NONE" })
vim.api.nvim_set_hl(0, "@markup.raw.markdown", { fg = "#89b8c2", bg = "NONE" })
vim.api.nvim_set_hl(0, "markdownCode", { fg = "#89b8c2", bg = "NONE" })
vim.api.nvim_set_hl(0, "markdownCodeDelimiter", { fg = "#89b8c2", bg = "NONE" })

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "PmenuSel", { link = "CursorLine" })
