-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages.
-- Add some plugins now if Neovim is started like `nvim -- some-file` because
-- they are needed during startup to work correctly.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use `main` branch since `master` branch is frozen, yet still default
    checkout = 'main',
    -- Update tree-sitter parser after plugin is updated
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  add({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    -- Same logic as for 'nvim-treesitter'
    checkout = 'main',
  })

  -- Ensure installed parsers for listed languages. Add to `languages`
  -- array languages which you want to have installed. To see available languages:
  -- - Execute `:=require('nvim-treesitter').get_available()`
  -- - Visit
  --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  local ensure_languages = {
    -- These are already installed.
    'go',
    'tsx',
    'lua',
    "vim",
    'css',
    'rust',
    'json',
    'html',
    'vimdoc',
    'markdown',
    'typescript',
    'javascript',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, ensure_languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Ensure tree-sitter enabled after opening a file for target language
  local filetypes = {}
  for _, lang in ipairs(ensure_languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

now_if_args(function()
  add('wakatime/vim-wakatime')
end)

now(function()
  add("vyfor/cord.nvim")
  require("cord").setup({
    enabled = true,
    log_level = vim.log.levels.OFF,
    editor = {
      client = "neovim",
      tooltip = "...",
      icon = "https://i.pinimg.com/736x/0e/0c/45/0e0c45d61502314907f24eeeb172e85d.jpg",
    },
    display = {
      theme = "classic",
      flavor = "dark",
      view = "full",
      swap_fields = true,
      swap_icons = true,
    },
    timestamp = {
      enabled = true,
      reset_on_idle = false,
      reset_on_change = false,
      shared = true,
    },
    idle = {
      enabled = true,
      timeout = 300000,
      show_status = true,
      ignore_focus = true,
      unidle_on_focus = true,
      smart_idle = true,
      details = "self-ragebaiting",
      state = nil,
      tooltip = "slebt?",
      icon = "https://i.pinimg.com/736x/6c/62/d9/6c62d9b289b2760cc60cdc66dc8f3088.jpg",
    },
    text = {
      default        = nil,
      workspace      = function(opts) return "in basement" end,
      viewing        = function(opts) return "staring at code " end,
      editing        = function(opts) return "editing code" end,
      file_browser   = function(opts) return "checking out files" end,
      plugin_manager = function(opts) return "managing thy plugins" end,
      lsp            = function(opts) return "lang server borked" end,
      docs           = function(opts) return "reading... something" end,
      vcs            = function(opts) return "commiting to break prod" end,
      notes          = function(opts) return "taking notes" end,
      debug          = function(opts) return "debugging?" end,
      test           = function(opts) return "testing..." end,
      diagnostics    = function(opts) return "fixing problems in not life" end,
      games          = function(opts) return "playing lol" end,
      terminal       = function(opts) return "running rm -rf in term" end,
      dashboard      = "zazamaxxing",
    },
    buttons = nil,
    assets = nil,
    variables = nil,
    hooks = {
      ready = nil,
      shutdown = nil,
      pre_activity = nil,
      post_activity = nil,
      idle_enter = nil,
      idle_leave = nil,
      workspace_change = nil,
      buf_enter = nil,
    },
    plugins = nil,
    advanced = {
      plugin = {
        autocmds = true,
        cursor_update = "on_hold",
        match_in_mappings = true,
      },
      server = {
        update = "fetch",
        pipe_path = nil,
        executable_path = nil,
        timeout = 300000,
      },
      discord = {
        pipe_paths = nil,
        reconnect = {
          enabled = true,
          interval = 5000,
          initial = true,
        },
      },
      workspace = {
        root_markers = { ".git", ".hg", ".svn" },
        limit_to_cwd = false,
      },
    },
  })
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Configurations for language servers are in 'after/lsp/' directory.
-- Each server has its own file (e.g., 'after/lsp/gopls.lua') that returns
-- a configuration table used by `vim.lsp.config()`.
--
-- Enable language servers using `vim.lsp.enable()`.
now_if_args(function()
  add('b0o/schemastore.nvim')
end)

now_if_args(function()
  add({
    source = 'saghen/blink.cmp',
    version = "v1.*",
    build = "cargo build --release",
    hooks = {
      post_checkout = function()
        vim.fn.system('cargo build --release')
      end,
    },
  })
  require('blink.cmp').setup({
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
        show_on_x_blocked_trigger_characters = {},
      },
      menu = {
        auto_show = false,
      },
      ghost_text = {
        enabled = false,
      },
    },
  })

  vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
end)

now_if_args(function()
  add('neovim/nvim-lspconfig')

  local lspconfig = require('lspconfig')
  local capabilities = require('blink.cmp').get_lsp_capabilities()

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
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  })

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
  })

  lspconfig.eslint.setup({
    capabilities = capabilities,
    root_dir = function(fname)
      -- Force eslint to use monorepo root config
      local root = require('lspconfig.util').root_pattern(
        'eslint.config.js',
        '.eslintrc.js',
        '.eslintrc.json',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.cjs',
        '.git'
      )(fname)
      return root
    end,
    settings = {
      workingDirectory = { mode = 'auto' }, -- Critical for monorepos
      format = { enable = true },
      lintTask = { enable = true },
      codeAction = {
        disableRuleComment = { enable = true, location = "separate_line" },
        showRuleId = true,
      },
      onChangeHandlers = { default = "all" },
      -- ADD TypeScript-specific settings
      -- typescript = {
      --   tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
      -- },
    },
    on_attach = function(client, bufnr)
      -- Your existing BufWritePre autocmd
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        command = 'EslintFixAll',
      })

      -- ADD: Ensure diagnostics show
      vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        callback = function()
          vim.cmd("EslintFixAll")
        end,
      })
    end,
    -- ADD: Filetype filtering
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
  })
end)



-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add('stevearc/conform.nvim')

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
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
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function() add('rafamadriz/friendly-snippets') end)

-- Honorable mentions =========================================================

-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- You can use it like so:
later(function()
  add("mason-org/mason.nvim")
  require('mason').setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end)

later(function()
  add("mason-org/mason-lspconfig.nvim")
  require('mason-lspconfig').setup({
    ensure_installed = {
      "vtsls",
      "jsonls",
      "lua_ls",
      "eslint",
    },
  })
end)

later(function()
  add('WhoIsSethDaniel/mason-tool-installer.nvim')
  require('mason-tool-installer').setup({
    ensure_installed = {
      "prettier",
    },
    auto_update = false,
    run_on_start = true,
  })
end)

later(function()
  add("ellisonleao/gruvbox.nvim")
  require('gruvbox').setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = false,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = true,
    invert_signs = false,
    invert_tabline = false,
    inverse = true,
    contrast = "hard",
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
  })
end)
