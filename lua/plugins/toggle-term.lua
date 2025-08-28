-- init.lua / plugin config
return {
  "waiting-for-dev/ergoterm.nvim",
  config = function()
    require("ergoterm").setup({
      terminal_defaults = {
        layout = "below",
        size = { below = "15" },
      },
    })
  end,
}
