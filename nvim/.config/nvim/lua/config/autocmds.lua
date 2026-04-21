-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("sync_yank"),
  callback = function()
    local data = vim.v.event.regcontents
    if vim.env.TMUX == nil then
      require("vim.ui.clipboard.osc52").copy("+")(data)
    end
    if type(data) == "table" then
      data = table.concat(data, "\n")
    end

    local buffer_path = vim.fn.expand("~/clip.buf")
    local buffer = io.open(buffer_path, "w")
    if buffer then
      buffer:write(data)
      buffer:close()
    end
  end,
})
