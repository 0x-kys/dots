return {
  "voltycodes/areyoulockedin.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    require("areyoulockedin").setup({
      session_key = "d5a20c52-08c7-4cb2-91c6-d4b0c62c4a65",
    })
  end,
}
