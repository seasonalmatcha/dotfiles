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

        map("n", "gj", gs.next_hunk)
        map("n", "gk", gs.prev_hunk)
        map("n", "<leader>gr", gs.reset_hunk)
        map("n", "<leader>gd", gs.diffthis)
        map("n", "<leader>gp", gs.preview_hunk)
      end,
    })
  end,
}
