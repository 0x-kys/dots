return {
  name = 'vtsls',
  config = {
    capabilities = nil,
    settings = {
      typescript = {
        maxTsServerMemory = 16384,
        tsserver = {
          maxTsServerMemory = 16384,
          useSeparateSyntaxServer = true,
          watchOptions = { watchFile = "useFsEvents", watchDirectory = "useFsEvents", fallbackPolling = "dynamicPriority", synchronousWatchDirectory = true },
        },
        suggest = { includeCompletionsForModuleExports = false, includeCompletionsForImportStatements = false },
        inlayHints = { enumMemberValues = { enabled = false }, functionLikeReturnTypes = { enabled = false }, parameterNames = { enabled = false }, parameterTypes = { enabled = false }, propertyDeclarationTypes = { enabled = false }, variableTypes = { enabled = false } },
        diagnostics = { ignoredCodes = {} },
        implementationsCodeLens = { enabled = false },
        referencesCodeLens = { enabled = false },
        includePackageJsonAutoImports = "off",
        preferences = { importModuleSpecifier = "relative", includeCompletionsForModuleExports = false, includeCompletionsForImportStatements = false },
      },
      javascript = {
        suggest = { includeCompletionsForModuleExports = false, includeCompletionsForImportStatements = false },
        preferences = { importModuleSpecifier = "relative", includeCompletionsForModuleExports = false, includeCompletionsForImportStatements = false },
      },
      vtsls = { experimental = { completion = { enableServerSideFuzzyMatch = true } } },
    },
    flags = { debounce_text_changes = 150 },
    init_options = { preferences = { disableAutomaticTypingAcquisition = true } },
  },
}
