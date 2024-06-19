return {
  "lewis6991/gitsigns.nvim",
  ft = { "gitcommit", "diff" },
  init = function()
    local aucmd = require("utils").aucmd
    -- load gitsigns only when a git file is opened
    aucmd({ "BufRead" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
      callback = function()
        vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
          vim.schedule(function()
            require("lazy").load({ plugins = { "gitsigns.nvim" } })
          end)
        end
      end,
    })
  end,
  config = function()
    local map = require("utils").map

    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      on_attach = function()
        local gs = package.loaded.gitsigns

        map("n", "gj", function()
          gs.next_hunk()
        end)
        map("n", "gk", function()
          gs.prev_hunk()
        end)
        map("n", "<leader>gr", function()
          gs.reset_hunk()
        end)
        map("n", "<leader>gd", function()
          gs.diffthis()
        end)
      end,
    })
  end,
}
