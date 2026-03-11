return {
  "Vigemus/iron.nvim",
  keys = {
    { "<space>rr", "<cmd>IronRepl<cr>",    desc = "REPL Toggle" },
    { "<space>rR", "<cmd>IronRestart<cr>", desc = "REPL Restart" },
    {
      "<space>sl",
      function()
        require("iron.core").send_line()
      end,
      desc = "REPL Send Line",
    },
    {
      "<space>sf",
      function()
        require("iron.core").send_file()
      end,
      desc = "REPL Send File",
    },
    {
      "<space>sc",
      function()
        require("iron.core").run_motion()
      end,
      desc = "REPL Send Motion",
    },
    {
      "<space>rs",
      function()
        require("iron.core").visual_send()
      end,
      mode = { "v" },
      desc = "REPL Visual Send",
    },
    {
      "<space>sp",
      function()
        require("iron.core").send_paragraph()
      end,
      desc = "REPL Send Paragraph",
    },
    {
      "<space>sb",
      function()
        require("iron.core").send_code_block(false)
      end,
      desc = "REPL Send Code Block",
    },
    {
      "<space>sn",
      function()
        require("iron.core").send_code_block(true)
      end,
      desc = "REPL Send Code Block (Move)",
    },
    {
      "<space>cl",
      function()
        require("iron.core").send(nil, string.char(12))
      end,
      desc = "REPL Clear",
    },
    {
      "<space>sq",
      function()
        require("iron.core").close_repl()
      end,
      desc = "REPL Quit",
    },
  },
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")

    iron.setup(
      {
        config = {
          repl_definition = {
            ocaml = {
              command = { "utop" },
              format = function(lines)
                table.insert(lines, ";;\13")
                return lines
              end
            }
          },
          repl_open_cmd = view.split.vertical.botright(60)
        },
      }
    )
  end,
}
