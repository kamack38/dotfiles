return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F8>",      "<cmd>DapContinue<cr>",         { desc = "Debug: Continue" } },
      { "<F10>",     "<cmd>DapStepOver<cr>",         { desc = "Debug: Step Over" } },
      { "<F11>",     "<cmd>DapStepInto<cr>",         { desc = "Debug: Step Into" } },
      { "<F12>",     "<cmd>DapStepOut<cr>",          { desc = "Debug: Step Out" } },
      { "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Debug: Toggle Breakpoint" } },
      { "<leader>B",
        function()
          local dap = require "dap"
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Conditional Breakpoint" }
      }
    },
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
            local command = "cd '" ..
                filedir ..
                "' && mkdir -p '" .. bindir .. "' && clang++ --debug '" .. filepath .. "' -o '" .. exepath .. "'"
            vim.fn.system(command)
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

      local dapui = require "dapui"
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

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    opts = {},
  }
}
