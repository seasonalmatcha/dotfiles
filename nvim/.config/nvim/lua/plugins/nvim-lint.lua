return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local aucmd = require("utils").aucmd

    local js_formatter = { "biomejs" }
    -- In case need to use eslint
    -- local js_formatter = { "eslint" }

    require("lint").linters_by_ft = {
      javascript = js_formatter,
      javascriptreact = js_formatter,
      typescript = js_formatter,
      typescriptreact = js_formatter,
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
