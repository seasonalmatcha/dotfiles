return {
  "echasnovski/mini.indentscope",
  version = "*",
  config = function()
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
