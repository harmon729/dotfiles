-- lua/plugins/dap.lua

return {
  "mfussenegger/nvim-dap",
  keys = {
    -- Session
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Launch/Continue" },
    { "<leader>dq", "<cmd>DapTerminate<cr>", desc = "Quit/Terminate" },
    { "<leader>dr", "<cmd>DapRestart<cr>", desc = "Restart" },

    -- Breakpoints
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Set Conditional Breakpoint",
    },
    {
      "<leader>dx",
      function()
        require("dap").clear_breakpoints()
        vim.notify("All breakpoints cleared", vim.log.levels.INFO)
      end,
      desc = "Clear All Breakpoints",
    },

    -- Stepping
    { "<leader>dj", "<cmd>DapStepOver<cr>", desc = "Step Over" },
    { "<leader>dl", "<cmd>DapStepInto<cr>", desc = "Step Into" },
    { "<leader>dh", "<cmd>DapStepOut<cr>", desc = "Step Out" },
    { "<leader>dk", "<cmd>DapRestartFrame<cr>", desc = "Restart Frame" },
    { "<leader>dp", "<cmd>DapPause<cr>", desc = "Pause Thread" },

    -- UI & Interface
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
    { "<leader>de", "<cmd>DapToggleRepl<cr>", desc = "Open/Close REPL" },
    { "<leader>dK", "<cmd>DapHover<cr>", mode = { "n", "v" }, desc = "Hover Variable" },
  },
  dependencies = {
    "mason-org/mason.nvim",

    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      opts = {
        ensure_installed = {
          "codelldb",
        },
        handlers = {},
      },
    },

    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",

        {
          "folke/lazydev.nvim",
          ft = "lua",
          opts = {
            library = {
              "nvim-dap-ui",
            },
          },
        },

        {
          "folke/lazydev.nvim",
          ft = "lua",
          opts = {
            library = {
              "nvim-dap",
            },
          },
        },
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        -- 在调试会话开始和结束时自动打开和关闭 DAP UI
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end,
    },
  },
  config = function()
    local dap = require("dap")
    -- local dapui = require("dapui")

    -- 定义 C++ 的调试配置模板
    dap.configurations.cpp = {
      {
        name = "[codelldb] Launch file (Lua Template)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        -- 如果你需要传递命令行参数
        -- args = {"arg1", "arg2"},
      },
    }

    -- 为 C 和 Rust 复用配置
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
