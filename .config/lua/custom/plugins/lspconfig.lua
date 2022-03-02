local M = {}

M.setup_lsp = function(attach, capabilities)
local lsp_installer = require "nvim-lsp-installer"

lsp_installer.settings {
   ui = {
      icons = {
         server_installed = "﫟" ,
         server_pending = "",
         server_uninstalled = "✗",
      },
   },
}

lsp_installer.on_server_ready(function(server)
   local opts = {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
         debounce_text_changes = 150,
      },
      settings = {},
   }
   
   -- if server.name == "powershell_es" then
   --   opts.settings = {
   --     bundle = '%LocalAppData%/nvim-data/powershell_es/PowerShellEditorServices',
   --     shell = "pwsh",
   --     single_file_support = true
   --   }
   -- end
   -- basic example to edit lsp server's options, disabling tsserver's inbuilt formatter
   if server.name == 'tsserver' then 
      opts.on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end
   end
   
   server:setup(opts)
   vim.cmd [[ do User LspAttachBuffers ]]
   end)
end

return M