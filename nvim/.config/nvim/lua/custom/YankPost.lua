local M = {}

--- 将最新的 Tmux 缓冲区内容写入临时文件进行测试
M.sync_to_file = function()
  -- 1. 定义临时文件的路径
  local temp_file = "~/yank.buf"

  -- 2. 获取 Tmux 缓冲区的内容
  -- 使用 vim.fn.system() 同步执行 shell 命令
  -- 注意：我们使用 show-buffer 而不是 paste-buffer
  local content = vim.fn.system("tmux show-buffer 2>/dev/null")

  -- 移除可能由 system() 带来的末尾换行符
  -- content = content:gsub("\n$", "")

  -- 3. 将内容写入临时文件 (使用 Lua io 库写入)
  local file = io.open(temp_file, "w")
  if file then
    -- file:write("--- [SYNC START] --- " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n")
    -- file:write(content .. "\n")
    file:write(content)
    -- file:write("--- [SYNC END] ---\n")
    io.close(file)

    -- 打印一个 VIM 消息，用于确认操作成功
    vim.notify("Content copied to: " .. temp_file, vim.log.levels.INFO)
  else
    vim.notify("ERROR: Could not write to " .. temp_file, vim.log.levels.ERROR)
  end
end

return M
