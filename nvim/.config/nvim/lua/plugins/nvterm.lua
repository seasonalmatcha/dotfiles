return {
  "NvChad/nvterm",
  config = function()
    local map = require("utils").map
    local nvterm = require("nvterm")
    local terminal = require("nvterm.terminal")

    nvterm.setup({
      terminals = {
        type_opts = {
          float = {
            col = 0.1,
            row = 0.075,
            width = 0.8,
            height = 0.8,
          },
          horizontal = {
            location = "rightbelow",
            split_ratio = 0.2,
          },
        },
      },
    })

    map({ "n", "t" }, "<a-i>", function()
      terminal.toggle("float")
    end)
    map({ "n", "t" }, "ˆ", function()
      terminal.toggle("float")
    end)
    map({ "n", "t" }, "<a-h>", function()
      terminal.toggle("horizontal")
    end)
    map({ "n", "t" }, "˙", function()
      terminal.toggle("horizontal")
    end)
    map({ "n", "t" }, "<a-v>", function()
      terminal.toggle("vertical")
    end)
    map({ "n", "t" }, "√", function()
      terminal.toggle("vertical")
    end)
  end,
}
