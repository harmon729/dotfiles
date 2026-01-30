local M = {}

M.sync_to_file = function()
  local clip_buf = vim.fn.expand("~/clip.buf")

  local content = vim.fn.system("tmux show-buffer 2>/dev/null")

  local file = io.open(clip_buf, "w")
  if file then
    file:write(content)
    io.close(file)

    vim.notify("Content copied to: " .. clip_buf, vim.log.levels.INFO)
  else
    vim.notify("ERROR: Could not write to " .. clip_buf, vim.log.levels.ERROR)
  end
end

return M
