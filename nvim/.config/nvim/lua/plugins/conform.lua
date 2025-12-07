return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
    local map = require("utils").map
    local aucmd = require("utils").aucmd
    local has_file = require("utils").has_file
    local conform = require("conform")

    local function js_formatter()
      if
        has_file({
          ".prettierrc",
          ".prettierrc.js",
          ".prettierrc.json",
          "prettierrc.json",
          "prettier.config.js",
          "prettier.config.ts",
          "prettier.config.mjs",
        })
      then
        return { "prettier", stop_after_first = true }
      else
        return { "biome", "biome-organize-imports" }
      end
    end

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = js_formatter,
        typescriptreact = js_formatter,
        javascript = js_formatter,
        javascriptreact = js_formatter,
        json = js_formatter,
        html = { "prettier" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        prisma = { "prismals" },
        dart = { "dart_format" },
        rust = { "rustfmt" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
      formatters = {
        biome = {
          command = function()
            local project_bin = vim.fn.fnamemodify("./node_modules/.bin/biome", ":p")
            if vim.fn.executable(project_bin) == 1 then
              return project_bin
            end

            return "biome"
          end,
          args = function(_, ctx)
            local project_config = vim.fn.findfile("biome.json", ".;")
            local args = { "format", "--stdin-file-path", ctx.filename }
            if project_config == "" then
              table.insert(args, 2, "--config-path")
              table.insert(args, 3, vim.fn.stdpath("config") .. "/biome.json")
            end
            return args
          end,
          stdin = true,
        },
      },
    })

    aucmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    map({ "i", "n" }, "<a-s-f>", "<cmd> Format <cr>")
    map({ "i", "n" }, "Ï", "<cmd> Format <cr>")
  end,
}
