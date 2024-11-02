return {
  "tamton-aquib/duck.nvim",
  config = function()
    local map = require("utils").map
    local duck = require("duck")
    local chars = { "🦆", "🦀", "🐈", "🐎", "🦖", "🐤" }

    map("n", "<leader>pp", function()
      duck.hatch()
    end)

    map("n", "<leader>pt", function()
      for _, char in ipairs(chars) do
        duck.hatch(char)
      end
    end)

    map("n", "<leader>pr", function()
      local char = chars[math.random(1, #chars)]
      duck.hatch(char)
    end)

    map("n", "<leader>pk", function()
      duck.cook()
    end)

    map("n", "<leader>pa", function()
      duck.cook_all()
    end)
  end,
}
