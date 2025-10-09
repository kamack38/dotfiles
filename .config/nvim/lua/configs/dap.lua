return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "n", "<F8>",      "<cmd>DapContinue<cr>",         { desc = "Debug: Continue" } },
      { "n", "<F10>",     "<cmd>DapStepOver<cr>",         { desc = "Debug: Step Over" } },
      { "n", "<F11>",     "<cmd>DapStepInto<cr>",         { desc = "Debug: Step Into" } },
      { "n", "<F12>",     "<cmd>DapStepOut<cr>",          { desc = "Debug: Step Out" } },
      { "n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Debug: Toggle Breakpoint" } },
      { "n", "<leader>B",
        function()
          local dap = require "dap"
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Conditional Breakpoint" }
      }
    },
    event = "VeryLazy",
    config = function()
      local dap = require "dap"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          externalTerminal = false,
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Compile & Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            local filepath = vim.api.nvim_buf_get_name(0)
            local filedir = vim.fn.fnamemodify(filepath, ":p:h")
            local filename = vim.fn.expand("%:t:r")
            local bindir = filedir .. "bin/debug"
            local exepath = bindir .. "/" .. filename
            vim.cmd("cd " ..
              filedir ..
              " && mkdir -p " .. bindir " && clang++ --debug " .. filepath .. " -o " .. exepath)
            return exepath
          end,
          cwd = "${workspaceFolder}",
          externalTerminal = false,
          stopOnEntry = false,
          args = {},
        },
      }

      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

      dap.set_log_level("DEBUG")
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    event = "VeryLazy",
    config = function()
      local dapui = require "dapui"
      local dap = require "dap"

      dapui.setup()
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
    end
  }
}
