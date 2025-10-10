return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.comment").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    -- require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.bufremove").setup()
    require("mini.diff").setup()
    require("mini.files").setup()
    require("mini.pick").setup()
    require("mini.sessions").setup()
    require("mini.git").setup()
    require("mini.jump").setup()
    require("mini.colors").setup()
    require("mini.cursorword").setup()
    require("mini.hipatterns").setup()
    require("mini.icons").setup()
    require("mini.starter").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.fuzzy").setup()
    require("mini.trailspace").setup()
    require("mini.extra").setup()

    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    })

    local map = vim.keymap.set

    map("n", "<leader>ff", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open file explorer" })
    map("n", "<leader>fc", "<cmd>lua MiniFiles.close()<cr>", { desc = "Close file explorer" })
    map("n", "<leader>fr", "<cmd>lua MiniFiles.refresh()<cr>", { desc = "Refresh file explorer" })

    map("n", "<leader>pf", "<cmd>Pick files<cr>", { desc = "Find files" })
    map("n", "<leader>pg", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
    map("n", "<leader>pb", "<cmd>Pick buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>ph", "<cmd>Pick help<cr>", { desc = "Find help" })
    map("n", "<leader>pr", "<cmd>Pick resume<cr>", { desc = "Resume last pick" })

    map("n", "<leader>bd", "<cmd>lua MiniBufremove.delete()<cr>", { desc = "Delete buffer" })
    map("n", "<leader>bw", "<cmd>lua MiniBufremove.wipeout()<cr>", { desc = "Wipeout buffer" })
    map("n", "<leader>bu", "<cmd>lua MiniBufremove.unshow()<cr>", { desc = "Unshow buffer" })

    map("n", "<leader>ss", "<cmd>lua MiniSessions.select()<cr>", { desc = "Select session" })
    map("n", "<leader>sw", "<cmd>lua MiniSessions.write()<cr>", { desc = "Write session" })
    map("n", "<leader>sd", "<cmd>lua MiniSessions.delete()<cr>", { desc = "Delete session" })
    map("n", "<leader>sl", "<cmd>lua MiniSessions.read()<cr>", { desc = "Load session" })

    map("n", "<leader>go", "<cmd>lua MiniGit.show_at_cursor()<cr>", { desc = "Show git info at cursor" })
    map({ "n", "x" }, "<leader>gs", "<cmd>lua MiniGit.show_diff_source()<cr>", { desc = "Show diff source" })
    map({ "n", "x" }, "<leader>gr", "<cmd>lua MiniGit.show_range_history()<cr>", { desc = "Show range history" })

    map("n", "<leader>do", "<cmd>lua MiniDiff.toggle_overlay()<cr>", { desc = "Toggle diff overlay" })

    map("n", "<leader>wt", "<cmd>lua MiniTrailspace.trim()<cr>", { desc = "Trim trailing whitespace" })
    map("n", "<leader>wl", "<cmd>lua MiniTrailspace.trim_last_lines()<cr>", { desc = "Trim last lines" })

    map("n", "<leader>tc", "<cmd>lua MiniTrailspace.highlight()<cr>", { desc = "Highlight trailspace" })
    map("n", "<leader>tt", "<cmd>lua MiniTrailspace.trim()<cr>", { desc = "Trim trailspace" })

    map("n", "<leader>/h", "<cmd>Pick history<cr>", { desc = "Search history" })
    map("n", "<leader>/r", "<cmd>Pick registers<cr>", { desc = "Search registers" })

    map({ "n", "v" }, "y", '"+y', { desc = "Yank to system clipboard" })
    map({ "n", "v" }, "p", '"+p', { desc = "Paste from system clipboard" })

    -- use fallback lsp to format buffer
    map("n", "<leader>fm", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })

    -- Esc remove search highlight
    map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
    map("n", "<leader>xx", "<cmd>Pick diagnostic<cr>", { desc = "All diagnostics" })
    map("n", "<leader>xd", "<cmd>Pick diagnostic scope='current'<cr>", { desc = "Buffer diagnostics" })
  end,
}
