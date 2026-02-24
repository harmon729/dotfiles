-- lua/plugins/utils.lua

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- Show hidden files
            ignored = true, -- Show ignored files
          },
        },
      },
    },
  },
}
