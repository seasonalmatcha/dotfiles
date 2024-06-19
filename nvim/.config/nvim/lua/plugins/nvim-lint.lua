return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local aucmd = require("utils").aucmd

    require("lint").linters_by_ft = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      go = { "golangcilint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    aucmd({ "BufEnter", "BufWritePre", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
