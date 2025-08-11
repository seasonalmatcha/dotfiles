local ensure_installed = {
  "dockerfile-language-server",
  "emmet-language-server",
  "goimports-reviser",
  "gofumpt",
  "golangci-lint",
  "golines",
  "gopls",
  "lua-language-server",
  "prettierd",
  "prisma-language-server",
  "rust-analyzer",
  "sqlls",
  "stylua",
  "tailwindcss-language-server",
  "templ",
  "typescript-language-server",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local map = require("utils").map
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = ensure_installed

      local servers = {
        "ts_ls",
        "prismals",
        "dockerls",
        "tailwindcss",
        "emmet_language_server",
        "gopls",
        "templ",
        "rust_analyzer",
      }

      local border = "rounded"

      vim.diagnostic.config({
        virtual_text = true,
        jump = {
          float = {
            border = border,
          },
        },
      })

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        map("n", "gD", function()
          vim.lsp.buf.declaration()
        end, opts)
        map("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
        map("n", "gl", function()
          vim.api.nvim_command("vsp")
          vim.lsp.buf.definition()
        end, opts)
        map("n", "gi", function()
          vim.lsp.buf.implementation()
        end, opts)
        map("n", "gr", function()
          vim.lsp.buf.references()
        end, opts)
        map("n", "gtd", function()
          vim.lsp.buf.type_definition()
        end, opts)
        map("n", "K", function()
          vim.lsp.buf.hover({ border = border })
        end, opts)
        map("n", "<leader>ls", function()
          vim.lsp.buf.signature_help({ border = border })
        end, opts)
        map("n", "<leader>D", function()
          vim.lsp.buf.type_definition()
        end, opts)
        map("n", "<leader>ca", function()
          vim.lsp.buf.code_action()
        end, opts)
        map("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, opts)
        map("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, opts)
        map("n", "<leader>kk", function()
          vim.diagnostic.jump({ count = -1 })
        end, opts)
        map("n", "<leader>jj", function()
          vim.diagnostic.jump({ count = 1 })
        end, opts)
        map("n", "<leader>lr", "<cmd> LspRestart <cr>")
      end

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = blink.get_lsp_capabilities(),
        })
      end

      require("flutter-tools").setup({
        lsp = {
          on_attach = on_attach,
          capabilities = blink.get_lsp_capabilities(),
        },
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = blink.get_lsp_capabilities(),
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      })
    end,
  },
}
