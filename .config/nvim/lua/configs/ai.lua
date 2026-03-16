return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  config = function()
    dofile(vim.g.base46_cache .. "avante")
    local options = {
      provider = "perplexity",
      vendors = {
        perplexity = {
          __inherited_from = "openai",
          api_key_name = { "cat", os.getenv("HOME") .. "/.keys/perplexity-api.key" },
          endpoint = "https://api.perplexity.ai",
          model = "llama-3.1-sonar-large-128k-online",
        },
      },
    }

    -- Use markdown textobjs
    local map = vim.keymap.set
    local group = vim.api.nvim_create_augroup("VariousTextobjs", {})
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "markdown", "Avante" },
      callback = function()
        local objName = "mdFencedCodeBlock"
        local name = " " .. objName .. " textobj"
        map({ "o", "x" }, "a" .. "C", ("<cmd>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "outer"),
          { desc = "outer" .. name, buffer = true })
        map({ "o", "x" }, "i" .. "C", ("<cmd>lua require('various-textobjs').%s('%s')<CR>"):format(objName, "inner"),
          { desc = "inner" .. name, buffer = true })
      end,
    })

    require("avante").setup(options)
  end,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
  },
}
