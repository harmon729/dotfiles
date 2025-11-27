-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local buffer_sync = require("custom.YankPost")

vim.api.nvim_create_augroup("YankBufferPost", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = "YankBufferPost",
  callback = function(_)
    -- 延时执行：确保 Tmux 缓冲区已更新
    vim.defer_fn(buffer_sync.sync_to_file, 50)
  end,
})
