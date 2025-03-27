return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "gpt4o",
          },
        },
      })
    end,
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
  },
  keys = {
    -- Normal Mode Operations
    { "<leader>aa", "<cmd>:CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "Launch AI" },
    { "<leader>ac", "<cmd>:CodeCompanionChat<CR>", mode = { "n", "v" }, desc = "Chat with AI" },
    { "<leader>ah", "<cmd>:CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "Toggle AI Chat Window" },

    -- Visual Mode Operations (Functions had to be seprated to retain replace/limited context operations)
    { "<leader>ae", ":'<,'>CodeCompanionChat /explain<CR>", mode = "v", desc = "Explain Code with AI" },
    { "<leader>af", ":'<,'>CodeCompanionChat /fix<CR>", mode = "v", desc = "Fix Code with AI" },
    { "<leader>al", ":'<,'>CodeCompanionChat /lsp<CR>", mode = "v", desc = "Explain LSP Diagnoses with AI" },
    { "<leader>at", ":'<,'>CodeCompanionChat /tests<CR>", mode = "v", desc = "Generate Tests with AI" },
  },
}
