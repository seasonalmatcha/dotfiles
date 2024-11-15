return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<Esc>",
      },
      color = {
        suggestion_color = "#acb0be",
        cterm = 244,
      },
      disable_inline_completion = false,
      disable_keymaps = false,
      ignore_filetypes = { "oil", "neo-tree" },
    })
  end,
}
