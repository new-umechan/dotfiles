return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {
      render_modes = { "n", "c", "t" },

      anti_conceal = {
        enabled = false,
      },

      heading = {
        enabled = true,
        sign = false,
        icons = { "", "", "", "", "", "" },
        position = "inline",
        width = "block",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        conceal_delimiters = false,
      },

      pipe_table = {
        enabled = true,
        preset = "none",
        style = "full",
        cell = "padded",
        padding = 1,
        min_width = 3,
        border_enabled = true,
        alignment_indicator = "─",
      },

      code = {
        enabled = true,
        sign = false,
        conceal_delimiters = true,
        language = true,
        position = "left",
        language_icon = true,
        language_name = true,
        language_info = true,
        width = "block",
        left_margin = 0,
        left_pad = 1,
        right_pad = 1,
        min_width = 0,
        border = "thin",
        above = "▄",
        below = "▀",
        inline = true,
        inline_left = "",
        inline_right = "",
        inline_pad = 0,
        highlight = "RenderMarkdownCode",
        highlight_info = "RenderMarkdownCodeInfo",
        highlight_border = "RenderMarkdownCodeBorder",
        highlight_inline = "RenderMarkdownCodeInline",
      },

      bullet = {
        enabled = true,
        icons = { "•", "◦", "▪", "▫" },
        left_pad = 0,
        right_pad = 1,
        highlight = "RenderMarkdownBullet",
      },

      checkbox = {
        enabled = false,
      },

      quote = {
        enabled = false,
      },

      win_options = {
        concealcursor = {
          rendered = "n",
          raw = "n",
        },
        conceallevel = {
          rendered = 2,
          raw = 0,
        },
      },
    },

    config = function(_, opts)
      require("render-markdown").setup(opts)

      local set_hl = vim.api.nvim_set_hl

      set_hl(0, "RenderMarkdownH1", { link = "Title" })
      set_hl(0, "RenderMarkdownH2", { bold = true, underline = true, fg = "#c6c8d1" })
      set_hl(0, "RenderMarkdownH3", { bold = true, fg = "#b8b9c4" })
      set_hl(0, "RenderMarkdownH4", { bold = true, fg = "#a8a9b5" })
      set_hl(0, "RenderMarkdownH5", { fg = "#9a9cab" })
      set_hl(0, "RenderMarkdownH6", { fg = "#8d90a0" })

      set_hl(0, "RenderMarkdownH1Bg", { bg = "NONE" })
      set_hl(0, "RenderMarkdownH2Bg", { bg = "NONE" })
      set_hl(0, "RenderMarkdownH3Bg", { bg = "NONE" })
      set_hl(0, "RenderMarkdownH4Bg", { bg = "NONE" })
      set_hl(0, "RenderMarkdownH5Bg", { bg = "NONE" })
      set_hl(0, "RenderMarkdownH6Bg", { bg = "NONE" })

      set_hl(0, "RenderMarkdownCode", { bg = "#0F1118" })
      set_hl(0, "RenderMarkdownCodeBorder", { fg = "#3a3f5a", bg = "#0F1118" })
      set_hl(0, "RenderMarkdownCodeInfo", { italic = true, fg = "#7f8490", bg = "#0F1118" })
      set_hl(0, "RenderMarkdownCodeInline", { bg = "NONE" })

      set_hl(0, "RenderMarkdownBullet", { link = "Comment" })

      set_hl(0, "RenderMarkdownTableHead", { bold = true })
      set_hl(0, "RenderMarkdownTableRow", {})
      set_hl(0, "RenderMarkdownTableFill", {})
    end,
  },
}
