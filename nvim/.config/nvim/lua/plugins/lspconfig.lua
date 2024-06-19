local ensure_installed = {
  "lua-language-server",
  "dockerfile-language-server",
  "gopls",
  "prettierd",
  "prisma-language-server",
  "sqlls",
  "typescript-language-server",
  "golines",
  "goimports",
  "golines",
  "rust-analyzer",
  "emmet-language-server",
  "stylua",
  "tailwindcss-language-server",
  "templ",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local map = require("utils").map
      require("mason").setup()
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = ensure_installed

      local servers = {
        "tsserver",
        "prismals",
        "dockerls",
        "tailwindcss",
        "emmet_language_server",
        "gopls",
        "templ",
      }

      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
        local opts = { buffer = bufnr, noremap = true, silent = true }

        map("n", "gD", function()
          vim.lsp.buf.declaration()
        end, opts)
        map("n", "gd", function()
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
          vim.lsp.buf.hover()
        end, opts)
        map("n", "<leader>ls", function()
          vim.lsp.buf.signature_help()
        end, opts)
        map("n", "<leader>D", function()
          vim.lsp.buf.type_definition()
        end, opts)
        map("n", "<leader>ca", function()
          vim.lsp.buf.code_action()
        end, opts)
        map("n", "[d", function()
          vim.diagnostic.goto_prev({ float = { border = "rounded" } })
        end, opts)
        map("n", "]d", function()
          vim.diagnostic.goto_next({ float = { border = "rounded" } })
        end, opts)
        map("n", "<leader>kk", function()
          vim.diagnostic.goto_prev({ float = { border = "rounded" } })
        end, opts)
        map("n", "<leader>jj", function()
          vim.diagnostic.goto_next({ float = { border = "rounded" } })
        end, opts)
        map("n", "<leader>lr", "<cmd> LspRestart <cr>")
      end

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
        })
      end

      lspconfig.lua_ls.setup({
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

      local win_style = {
        border = "rounded",
      }

      require("lspconfig.ui.windows").default_options = win_style
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, win_style)
    end,
  },
}
