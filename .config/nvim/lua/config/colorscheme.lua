vim.cmd('colorscheme iceberg')

local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl
local vs = get_hl(0, { name = "VertSplit" })

-- icebergへの不満箇所
set_hl(0, "WinSeparator", { fg = vs.fg, bg = vs.bg })
set_hl(0, "WarningMsg", { fg = "#6A708B", bg = "NONE" })
set_hl(0, "DiagnosticWarn", { fg = "#6A708B", bg = "NONE" })

set_hl(0, "RenderMarkdownUnchecked", { fg = "#84a0c6", bg = "NONE" })
set_hl(0, "RenderMarkdownChecked",   { fg = "#6b7089", bg = "NONE" })

set_hl(0, "@markup.raw", { fg = "#89b8c2", bg = "NONE" })
set_hl(0, "@markup.raw.markdown", { fg = "#89b8c2", bg = "NONE" })
set_hl(0, "markdownCode", { fg = "#89b8c2", bg = "NONE" })
set_hl(0, "markdownCodeDelimiter", { fg = "#89b8c2", bg = "NONE" })

set_hl(0, "NormalFloat", { link = "Normal" })
set_hl(0, "Pmenu", { link = "Normal" })
set_hl(0, "PmenuSel", { link = "CursorLine" })

-- set_hl(0, "RenderMarkdownDash", { fg = vs.fg, bg = vs.bg })
