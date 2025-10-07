return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines
        contrast = "hard", -- can be "hard", "soft", or leave empty for normal
        palette_overrides = {},
        overrides = {
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          LineNr = { bg = "NONE" },
          CursorLineNr = { bg = "NONE" },
          VertSplit = { bg = "NONE" },
          WinSeparator = { bg = "NONE" },
          StatusLine = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          Pmenu = { bg = "NONE" },
          PmenuSel = { bg = "#3c3836" },
          TelescopeNormal = { bg = "NONE" },
          TelescopeBorder = { bg = "NONE" },
          NvimTreeNormal = { bg = "NONE" },
          NvimTreeWinSeparator = { bg = "NONE" },
        },
        dim_inactive = false,
        transparent_mode = true,
      })

      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },
  {
    "mawkler/modicator.nvim",
    dependencies = { "ellisonleao/gruvbox.nvim" },
    event = "VeryLazy",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function()
      require("modicator").setup({
        show_warnings = true,
        integration = {
          lualine = {
            enabled = true,
            mode_section = nil,
            highlight = "bg",
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "none",
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          enforce_regular_tabs = true,
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
        },
        highlights = {
          fill = { bg = "NONE" },
          background = { bg = "NONE" },
          buffer_selected = { bg = "NONE" },
          separator = { bg = "NONE" },
          separator_selected = { bg = "NONE" },
          indicator_selected = { bg = "NONE" },
        },
      })
    end,
  },
}
