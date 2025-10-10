local opt = vim.opt

opt.conceallevel = 1
opt.cmdheight = 0

opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 8
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true

opt.pumblend = 0

opt.expandtab = true
opt.shiftwidth = 2
opt.wrap = true

vim.g.snacks_animate = false

vim.g.root_spec = { "cwd" }
vim.g.omni_sql_no_default_maps = 1

opt.linebreak = true -- Wrap lines at word boundaries
opt.breakindent = true -- Indent wrapped lines to match original indentation
opt.showbreak = "↳ " -- String to show at the start of wrapped lines
opt.wildignore:append({ "*/node_modules/*" })

opt.cursorline = true -- Highlight cursor line (like Helix's inline diagnostics)
opt.showmode = false -- Hide mode in command line (lualine shows it)
opt.signcolumn = "yes" -- Always show sign column for diagnostics
opt.list = true -- Show whitespace characters

-- Indent guides
opt.list = false

-- Enable persistent undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Inline diagnostics
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
  float = {
    source = "always",
    border = "rounded",
    format = function(diagnostic)
      return string.format("%s (%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code or "")
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- use retrobox else minisummer
local ok, _ = pcall(vim.cmd, "colorscheme retrobox")
if not ok then
  vim.cmd("colorscheme minisummer") -- if the above fails, then use default
end
