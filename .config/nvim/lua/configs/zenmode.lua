require("zen-mode").setup {
  window = {
    backdrop = 0.93,
    width = 120,
    height = 1,
  },
  plugins = {
    options = {
      showcmd = false, -- disables the command in the last line of the screen
    },
    gitsigns = { enabled = false },
    kitty = {
      enabled = true,
      font = "+2",
    },
  },
}
