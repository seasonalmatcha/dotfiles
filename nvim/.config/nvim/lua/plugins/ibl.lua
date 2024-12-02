return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  enabled = false,
  config = function()
    require("ibl").setup({
      indent = { char = "│" },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
      },
      config = function()
        require("ibl").setup({
          indent = { char = "│" },
          whitespace = {
            remove_blankline_trail = false,
          },
          scope = {
            enabled = true,
          },
        })
      end,
    })
  end,
}
