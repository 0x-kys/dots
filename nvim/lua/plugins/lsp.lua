return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
          command = "lua-language-server",
        },
        gopls = {
          mason = false,
          command = "gopls",
        },
        nil_ls = {
          mason = false,
          command = "nil",
        },
        vtsls = {
          mason = false,
          command = "vtsls",
          settings = {
            typescript = {
              -- Performance optimizations
              maxTsServerMemory = 16384, -- Increase memory limit to 16GB (MB)
              tsserver = {
                maxTsServerMemory = 16384,
                -- Use separate syntax server for better performance
                useSeparateSyntaxServer = true,
                -- Disable file watching for better performance
                watchOptions = {
                  watchFile = "useFsEvents",
                  watchDirectory = "useFsEvents",
                  fallbackPolling = "dynamicPriority",
                  synchronousWatchDirectory = true,
                },
              },
              -- Disable expensive features
              suggest = {
                -- Reduce suggestion overhead
                includeCompletionsForModuleExports = false,
                includeCompletionsForImportStatements = false,
              },
              -- Disable inlay hints (you already have these disabled)
              inlayHints = {
                enumMemberValues = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = false },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                variableTypes = { enabled = false },
              },
              -- Reduce diagnostic overhead
              diagnostics = {
                -- Only show errors, not warnings/info
                ignoredCodes = {},
              },
              -- Disable some heavy features
              implementationsCodeLens = { enabled = false },
              referencesCodeLens = { enabled = false },
              -- Optimize imports
              includePackageJsonAutoImports = "off",
              preferences = {
                -- Faster import resolution
                importModuleSpecifier = "relative",
                includeCompletionsForModuleExports = false,
                includeCompletionsForImportStatements = false,
              },
            },
            javascript = {
              -- Same optimizations for JavaScript
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
            -- Global vtsls settings
            vtsls = {
              -- Enable experimental features for better performance
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
          },
          -- Additional LSP client optimizations
          flags = {
            debounce_text_changes = 150, -- Debounce changes
          },
          -- Reduce server startup overhead
          init_options = {
            preferences = {
              -- Disable automatic type acquisition
              disableAutomaticTypingAcquisition = true,
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
        lua = { "stylua" },
        nix = { "alejandra" },
      },
      formatters = {
        stylua = {
          command = "stylua",
          mason = false,
        },
        alejandra = {
          command = "alejandra",
          mason = false,
        },
      },
    },
  },
}
