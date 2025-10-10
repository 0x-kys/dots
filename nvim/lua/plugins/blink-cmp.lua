return {
  "saghen/blink.cmp",
  version = "v1.*",
  build = "cargo build --release",
  opts = {
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
  },
  keys = {
    {
      "<C-n>",
      function()
        require("blink.cmp").show()
      end,
      mode = "i",
      desc = "Show completions",
    },
  },
}
