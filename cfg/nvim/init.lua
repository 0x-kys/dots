-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.hidden = true
vim.opt.wrap = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "/home/syk/.vim/undodir"
vim.opt.undofile = true
vim.o.showmode = false

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    {
      "aliqyan-21/darkvoid.nvim",
      priority = 1000,
    },
    {
      -- darkvoid: "aliqyan-21/darkvoid.nvim",
      -- kanagawa: "rebelot/kanagawa.nvim"
      "rebelot/kanagawa.nvim",
      priority = 1000,
    },
    {

      "nvim-tree/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({})
      end,
    },
    {
      'IogaMaster/neocord',
      event = "VeryLazy"
    },
    {
      "phaazon/hop.nvim",
      lazy = true,
      config = function()
        require('hop').setup({
          keys = 'etovxqpdygfblzhckisuran',
          case_insensitive = true,
          multi_windows = true,
        })
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && bun install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },
    {
      "hedyhli/outline.nvim",
      lazy = true,
      cmd = { "Outline", "OutlineOpen" },
      keys = {
        { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
      },
      opts = {},
      config = function()
        require("outline").setup({
          outline_window = {
            position = 'right',
            split_command = nil,
            width = 25,
            relative_width = true,
            auto_close = false,
            auto_jump = false,
            jump_highlight_duration = 300,
            center_on_jump = true,
            show_numbers = false,
            show_relative_numbers = false,
            wrap = false,
            show_cursorline = true,
            hide_cursor = false,
            focus_on_open = true,
            winhl = '',
          },

        })
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      config = function()
        require("ibl").setup({})
      end,
    },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
      config = function()
        require("typescript-tools").setup {
          on_attach =
              function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
          settings = {
            jsx_close_tag = {
              enable = true,
              filetypes = { "javascriptreact", "typescriptreact" },
            }
          }
        }
      end
    },
    {
      'romgrk/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim',     -- for git status
        'nvim-tree/nvim-web-devicons', -- for file icons
      },
      init = function() vim.g.barbar_auto_setup = false end,
      opts = {
        animation = true,
        insert_at_start = false,
        sidebar_filetypes = {
          NvimTree = true,
          undotree = {
            text = 'undotree',
            align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
          },
          ['neo-tree'] = { event = 'BufWipeout' },
          Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
        },
        name_formatter = function(buf)
          -- Only return the filename
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
        end,
      },
      version = '^1.0.0',
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require('lualine').setup {
          options = {
            component_separators = '',
            section_separators = { left = '', right = '' },
            globalstatus = true,
            always_divide_middle = true,
          },
          sections = {
            lualine_a = {
              'mode'
            },
            lualine_b = {
              'filename',
              'branch',
              'diff',
              'readonly',
              'modified'
            },
            lualine_c = {},
            lualine_x = {
              'diagnostics',
              'fileformat',
              'encoding',
            },
            lualine_y = {
              'progress',
              'selectioncount',
              'searchcount'
            },
            lualine_z = {
              'location',
              'scrollbar'
            },
          },
          inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
          },
          tabline = {},
          extensions = {},
        }
      end,
    },
    {
      "goolord/alpha-nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        local dashboard = require("alpha.themes.startify")

        -- Helper function to generate a random color in hex format
        local function randomColor()
          local function randHex()
            return string.format("%02x", math.random(0, 255))
          end
          return "#" .. randHex() .. randHex() .. randHex()
        end

        local function applyRandomColor(logo)
          dashboard.section.header.val = logo

          -- Generate a random color and create a highlight group for it
          local random_fg_color = randomColor()
          local hl_group = "AlphaRandomColor"
          vim.api.nvim_set_hl(0, hl_group, { fg = random_fg_color })

          -- Apply the highlight group to the entire header
          dashboard.section.header.opts.hl = hl_group
          return dashboard.opts
        end

        require("alpha").setup(applyRandomColor({
          [[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
          [[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
          [[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
          [[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
          [[██   ████ ███████  ██████    ████   ██ ██      ██]]
        }))
      end,
    },
    {
      "akinsho/bufferline.nvim",
      version = "*",
    },
    {
      'numToStr/Comment.nvim',
      opts = {},
      config = function()
        require('Comment').setup({
          padding = true,
          sticky = true,
          ignore = nil,

          toggler = {
            line = 'gcc',
            block = 'gbc',
          },

          opleader = {
            line = 'gc',
            block = 'gb',
          },

          -- extra mapping
          extra = {
            above = 'gcO',
            below = 'gco',
            eol = 'gcA',
          },

          -- enable keybinds
          mappings = {
            basic = true,
            extra = true,
          },

          pre_hook = nil,
          post_hook = nil,
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      main = "nvim-treesitter.configs", -- Added main field for correct setup
      config = function()
        require('nvim-treesitter').setup({
          ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "html", "javascript", "css", "typescript", "svelte" },
          sync_install = true,

          auto_install = true,

          highlight = {
            enable = true,

            disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,

            additional_vim_regex_highlighting = true,
          },
          indent = { enable = true },
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
          }
        })

        -- Force-enable Tree-sitter highlighting for all buffers
        vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufNewFile" }, {
          callback = function()
            vim.cmd("TSBufEnable highlight")
          end,
        })
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp"
    },
    {
      "hrsh7th/nvim-cmp",
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' }, -- LSP source
        { 'hrsh7th/cmp-buffer' },   -- Buffer source
        { 'hrsh7th/cmp-path' },     -- Path source
        { 'L3MON4D3/LuaSnip' },     -- luasnip
      },
      config = function()
        require('cmp').setup({
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'cmp_snippet' },
            { name = 'cmp_treesitter' },
            { name = 'luasnip' },
          },
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          mapping = require('cmp').mapping.preset.insert({
            ['<C-b>'] = require('cmp').mapping.scroll_docs(-4),
            ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
            ['<C-Space>'] = require('cmp').mapping.complete(),
            ['<C-e>'] = require('cmp').mapping.abort(),
            ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
          })
        })
      end,
    },
    {
      'neovim/nvim-lspconfig',
      requires = {
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
      },
    },
    {
      'hrsh7th/cmp-nvim-lsp',
      requires = {
        { 'hrsh7th/nvim-cmp' },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup()
      end,
    },
    {
      'boganworld/crackboard.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local function read_session_key()
          local path = vim.fn.expand("$HOME/.crackboard.cfg")
          local file = io.open(path, "r")

          if not file then
            print("Error: Unable to open $HOME/.crackboard.cfg")
            return nil
          end

          for line in file:lines() do
            local key, value = line:match("^(%S+)%s*=%s*(%S+)")
            if key == "session_key" then
              file:close()
              return value
            end
          end

          file:close()
          return nil
        end

        local session_key = read_session_key()
        if session_key then
          require('crackboard').setup({
            session_key = session_key,
          })
        else
          print("Error: session_key not found in ~/.crackboard.cfg")
        end
      end,
    },
    {
      'wakatime/vim-wakatime', lazy = false
    }
  },
  -- darkvoid
  install = { colorscheme = { "kanagawa" } }, --
  checker = { enabled = true },
})

-- Colorscheme
vim.opt.background = "dark"            -- switch between dark or light
vim.cmd("colorscheme kanagawa-dragon") -- darkvoid, ( kanagawa-(wave/dragon/lotus) )
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- CMP languages
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local vsclangserver_capabilities = vim.lsp.protocol.make_client_capabilities()
vsclangserver_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Nix
require('lspconfig').nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})

-- Lua
require('lspconfig').lua_ls.setup {}

-- Go
require('lspconfig').gopls.setup {
  capabilities = capabilities,
}
require('lspconfig').golangci_lint_ls.setup {}

-- JavaScript, ReactJS, TypeScript
require('lspconfig').ts_ls.setup {
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = false,
    },
  },
  exclude = {
    "node_modules"
  },
}

-- Tailwind CSS
require('lspconfig').tailwindcss.setup { capabilities = capabilities }

-- Astro
require 'lspconfig'.astro.setup { capabilities = capabilities }

-- CSS LS
require('lspconfig').cssls.setup {
  capabilities = vsclangserver_capabilities,
}
require('lspconfig').css_variables.setup {}
require('lspconfig').cssmodules_ls.setup {}

-- C, C++
require('lspconfig').clangd.setup { capabilities = capabilities, }

-- Rust
require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      }
    }
  }
}

-- Markdown
require('lspconfig').marksman.setup { capabilities = capabilities, }

-- Zig (zls)
require('lspconfig').zls.setup { capabilities = capabilities, }

-- Assembly (asm_lsp)
require('lspconfig').asm_lsp.setup { capabilities = capabilities, }

-- HTML (vscode-langservers-extracted)
require('lspconfig').html.setup { capabilities = vsclangserver_capabilities, }

-- Svelte (svelte-language-server)
require('lspconfig').svelte.setup { capabilities = capabilities }

-- Python (pyright)
require('lspconfig').pyright.setup { capabilities = capabilities }

-- Telescope Keybinds
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Keybindings for switching between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- hop keybinds
local hop = require('hop')
local directions = require('hop.hint').HintDirection

-- modern autoformat on save
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end
})

-- Keybindings
vim.api.nvim_set_keymap("n", "fw", ":HopWord<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fc", ":HopChar1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fb", ":HopChar2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fp", ":HopPattern<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fl", ":HopLine<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fs", ":HopLineStart<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fa", ":HopAnywhere<CR>", { noremap = true, silent = true })

-- multi-window support
vim.api.nvim_set_keymap("n", "fw", ":hopwordmw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fc", ":hopchar1mw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fb", ":hopchar2mw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fp", ":hoppatternmw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fl", ":hoplinemw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fs", ":hoplinestartmw<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fa", ":hopanywheremw<cr>", { noremap = true, silent = true })

-- Clipboard

-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true })

-- BarBar keybinds
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer

-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Mouse Support
vim.opt.mouse = "a"

-- Colorscheme
vim.opt.termguicolors = true

-- Clear `/` search pattern
vim.api.nvim_set_keymap('n', '<leader>s', ':let @/ = ""<CR>', { silent = true })

-- Word Wrapping
vim.o.textwidth = 0
vim.o.wrapmargin = 0
-- visual wrap (no real line cutting is made)
vim.o.linebreak = true -- breaks by word rather than character

-- Create directory + file with :E
vim.api.nvim_create_user_command('E', function(opts)
  local filepath = vim.fn.expand(opts.args)
  local dir = vim.fn.fnamemodify(filepath, ":p:h")
  if not vim.loop.fs_stat(dir) then
    vim.fn.mkdir(dir, "p")
  end
  vim.cmd("edit " .. filepath)
end, { nargs = 1, complete = "file" })

-- Discord RPC
require("neocord").setup({
  -- General options
  logo                = "auto",                -- "auto" or url
  logo_tooltip        = ":3",                  -- nil or string
  main_image          = "language",            -- "language" or "logo"
  client_id           = "1157438221865717891", -- Use your own Discord application client id (not recommended)
  log_level           = nil,                   -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
  debounce_timeout    = 10,                    -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
  blacklist           = {},                    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
  file_assets         = {},                    -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
  show_time           = false,                 -- Show the timer
  global_timer        = false,                 -- if set true, timer won't update when any event are triggered
  enable_line_number  = 1,
  editing_text        = "Editing %s",          -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
  file_explorer_text  = "Browsing...",         -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
  git_commit_text     = "Committing changes",  -- Format string rendered when committing changes in git (either string or function(filename: string): string)
  plugin_manager_text = "Managing plugins",    -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
  reading_text        = "Reading %s",          -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
  workspace_text      = "[REDACTED]",          -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
  line_number_text    = "Line %s out of %s",   -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
  terminal_text       = "Using Terminal",      -- Format string rendered when in terminal mode.
})

-- make sutff transparent
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none

  highlight SignColumn guibg=none
  highlight StatusLine guibg=none
  highlight VertSplit guibg=none
  highlight TabLine guibg=none
  highlight LineNr guibg=none
  highlight CursorLineNr guibg=none
  highlight EndOfBuffer guibg=none
  highlight FoldColumn guibg=none
]]
