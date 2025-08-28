local show_detail = false

local to_hide = {
  "node_modules",
  "dist",
  "coverage",
  "build",
}

return {
  "stevearc/oil.nvim",
  config = function()
    local map = require("utils").map
    local oil = require("oil")

    local function toggle_detail()
      show_detail = not show_detail

      if show_detail then
        oil.set_columns({ "icon", "permissions", "size", "mtime" })
      else
        oil.set_columns({ "icon" })
      end
    end

    oil.setup({
      keymaps = {
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
        ["<leader>v"] = { "actions.select", opts = { vertical = true } },
        ["<leader>h"] = { "actions.select", opts = { horizontal = true } },
        ["<backspace>"] = { "actions.parent" },
        ["."] = { "actions.toggle_hidden" },
        ["gd"] = toggle_detail,
        ["<C-d>"] = { "actions.preview_scroll_down" },
        ["<C-u>"] = { "actions.preview_scroll_up" },
      },
      float = {
        padding = 2,
        max_width = 80,
        border = "rounded",
      },
      view_options = {
        is_hidden_file = function(name, _)
          if name:sub(1, 1) == "." then
            return true
          end
          for _, pattern in ipairs(to_hide) do
            if name == pattern then
              return true
            end
          end
          return false
        end,
      },
    })

    map("n", "<leader>e", function()
      oil.open_float(vim.fn.getcwd())
    end)

    map("n", "<leader>o", function()
      oil.open_float()
    end)
  end,
}
