-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local util = require("lazyvim.util")
local snacks = require("snacks")

vim.keymap.set("n", "<C-/>", function()
  snacks.terminal(nil, { border = "none" })
end, { desc = "Term with border" })

vim.keymap.set("n", "<leader>gg", function()
  snacks.terminal({ "lazygit" }, { cwd = util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { desc = "Lazygit (root dir)" })

keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)

local function warn_arrow()
  vim.notify("stop using arrow keys dawg...", vim.log.levels.WARN)
end

keymap.set({ "n", "i", "v" }, "<Up>", warn_arrow, { noremap = true, silent = true })
keymap.set({ "n", "i", "v" }, "<Down>", warn_arrow, { noremap = true, silent = true })
keymap.set({ "n", "i", "v" }, "<Left>", warn_arrow, { noremap = true, silent = true })
keymap.set({ "n", "i", "v" }, "<Right>", warn_arrow, { noremap = true, silent = true })

-- Hover info
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", silent = true })

-- Show diagnostics in float (under cursor)
vim.keymap.set("n", "<leader>D", function()
  vim.diagnostic.open_float(nil, { border = "rounded", wrap = true })
end, { desc = "Line Diagnostics" })

-- Open full Trouble list
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble" })

-- Undo/Redo mappings
vim.keymap.set("n", "u", "u", { desc = "Undo" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Prevent accidental suspension
-- vim.keymap.del("n", "<C-z>", { silent = true })
