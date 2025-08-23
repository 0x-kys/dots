vim.cmd([[set mouse=]])
vim.opt.winborder = "rounded"
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = 'a'
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true -- Wrap lines at word boundaries
vim.opt.breakindent = true -- Indent wrapped lines to match original indentation
vim.opt.showbreak = "↳ " -- String to show at the start of wrapped lines

-- vim.opt.showtabline = 2 -- Always show tabline (like Helix's bufferline)
vim.opt.cursorline = true -- Highlight cursor line (like Helix's inline diagnostics)
vim.opt.showmode = false -- Hide mode in command line (lualine shows it)
vim.opt.signcolumn = "yes" -- Always show sign column for diagnostics
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = "→ ", space = " ", nbsp = "⍽", eol = "⏎" } -- Whitespace characters

-- Indent guides
vim.opt.listchars:append({ lead = "╎" })
vim.opt.list = true

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>v', ':e $MYVIMRC<CR>')
map('n', '<leader>z', ':e ~/.config/zsh/.zshrc<CR>')
map('n', '<leader>s', ':e #<CR>')
map('n', '<leader>S', ':sf #<CR>')
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')
map({ 'n', 'v' }, '<leader>c', '1z=')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		}
	},
	{ src = 'https://github.com/NvChad/showkeys',             opt = true },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saghen/blink.cmp",            build = 'cargo build --release' },
	{ src = "https://github.com/saghen/blink.compat" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/nvimdev/guard.nvim" },
})

require "mason".setup({
	ui = {
		border = nil,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

require "mason-lspconfig".setup({
	ensure_installed = { "clangd", "gopls", "vtsls", "eslint", "bashls", "fish_lsp", "golangci_lint_ls", "lua_ls", "html", "svelte", "jsonls" }
})

require "lspconfig".vtsls = {
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = { enabled = false },
				functionLikeReturnTypes = { enabled = false },
				parameterNames = { enabled = false },
				parameterTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = false },
				variableTypes = { enabled = false },
			},
		},
	},
}

require "lspconfig".gopls = {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = false,
			},
		},
	}
}


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

require "showkeys".setup({ position = "top-right" })
require "mini.pick".setup()
require "oil".setup()

-- Disable "No information available" notification on hover
-- plus define border for hover window
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config
			or {
				border = {
					{ "╭", "Comment" },
					{ "─", "Comment" },
					{ "╮", "Comment" },
					{ "│", "Comment" },
					{ "╯", "Comment" },
					{ "─", "Comment" },
					{ "╰", "Comment" },
					{ "│", "Comment" },
				},
			}
	config.focus_id = ctx.method

	if not (result and result.contents) then
		return
	end

	local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

	if vim.tbl_isempty(markdown_lines) then
		return
	end

	return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('t', '', "")
map('t', '', "")
map('n', '<leader>lf', vim.lsp.buf.format)

vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('x', 'y', '"+y')

vim.lsp.enable({ "lua_ls", "svelte", "tinymist", "emmetls" })
require('nvim-treesitter.configs').setup({ highlight = { enable = true, }, })

-- colors
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- snippets
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")
map("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
-- map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

vim.lsp.config('vtsls', {
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = { enabled = false },
				functionLikeReturnTypes = { enabled = false },
				parameterNames = { enabled = false },
				parameterTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = false },
				variableTypes = { enabled = false },
			},
		},
	},
})


vim.lsp.config('gopls', {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = false,
				compositeLiteralTypes = false,
				constantValues = false,
				functionTypeParameters = false,
				parameterNames = false,
				rangeVariableTypes = false,
			},
		},
	},
})
