return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      lspconfig.vtsls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            maxTsServerMemory = 16384,
            tsserver = {
              maxTsServerMemory = 16384,
              useSeparateSyntaxServer = true,
              watchOptions = {
                watchFile = "useFsEvents",
                watchDirectory = "useFsEvents",
                fallbackPolling = "dynamicPriority",
                synchronousWatchDirectory = true,
              },
            },
            suggest = {
              includeCompletionsForModuleExports = false,
              includeCompletionsForImportStatements = false,
            },
            inlayHints = {
              enumMemberValues = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              parameterNames = { enabled = false },
              parameterTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              variableTypes = { enabled = false },
            },
            diagnostics = {
              ignoredCodes = {},
            },
            implementationsCodeLens = { enabled = false },
            referencesCodeLens = { enabled = false },
            includePackageJsonAutoImports = "off",
            preferences = {
              importModuleSpecifier = "relative",
              includeCompletionsForModuleExports = false,
              includeCompletionsForImportStatements = false,
            },
          },
          javascript = {
            suggest = {
              includeCompletionsForModuleExports = false,
              includeCompletionsForImportStatements = false,
            },
            preferences = {
              importModuleSpecifier = "relative",
              includeCompletionsForModuleExports = false,
              includeCompletionsForImportStatements = false,
            },
          },
          vtsls = {
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
        flags = {
          debounce_text_changes = 150,
        },
        init_options = {
          preferences = {
            disableAutomaticTypingAcquisition = true,
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
    end,
  },
  {
    "b0o/schemastore.nvim",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load earlier
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          rust = { "rustfmt" },
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
        },
        formatters = {
          prettier = {
            require_cwd = true,
          },
        },
      })

      -- Explicit autocmd for format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf, async = true, lsp_fallback = true })
        end,
      })
    end,
  },
}
