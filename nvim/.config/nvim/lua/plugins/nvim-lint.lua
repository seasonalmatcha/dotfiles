return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local aucmd = require("utils").aucmd
    local has_file = require("utils").has_file

    local function js_linter()
      if
        has_file({
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.json",
          "eslintrc.json",
          "eslint.config.js",
          "eslint.config.ts",
          "eslint.config.mjs",
        })
      then
        return { "eslint" }
      else
        return { "biomejs" }
      end
    end

    require("lint").linters_by_ft = {
      javascript = js_linter(),
      javascriptreact = js_linter(),
      typescript = js_linter(),
      typescriptreact = js_linter(),
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
