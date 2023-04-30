local dap = require "dap"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/usr/bin/codelldb",
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

-- dap.adapters.cpp = {
--   type = "executable",
--   attach = {
--     pidProperty = "pid",
--     pidSelect = "ask",
--   },
--   command = "codelldb",
--   env = {
--     LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
--   },
--   name = "lldb",
-- }

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
}

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
