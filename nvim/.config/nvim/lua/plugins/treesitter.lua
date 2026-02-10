-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "css",
      "latex",
      "scss",
      "svelte",
      "typst",
      "vue",
    },
  },
}
