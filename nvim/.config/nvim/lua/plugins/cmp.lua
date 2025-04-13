return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<c-u>"] = { "scroll_documentation_up", "fallback" },
        ["<c-d>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        menu = {
          min_width = 50,
          border = "rounded",
          winhighlight = "Normal:FloatBorder",
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
            winhighlight = "Normal:FloatBorder",
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winhighlight = "Normal:FloatBorder",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
