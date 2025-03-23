return {
  "echasnovski/mini.nvim",
  config = function()
    -- require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()

    local indent = require("mini.indentscope")
    indent.setup({
      symbol = "│",
      draw = {
        delay = 0,
        animation = indent.gen_animation.none(),
      },
    })
  end,
}
