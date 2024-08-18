return {
  {
    "David-Kunz/gen.nvim",
    cond = function()
      return vim.env.SYSTEM_USAGE_TYPE == "personal"
    end,
    init = function() end,
    opts = {
      model = "llama3.1",
      display_mode = "split",
    },
    keys = {
      -- Normal Mode Operations
      { "<leader>aa", "<cmd>:Gen<CR>", mode = "n", desc = "Launch AI" },
      { "<leader>ac", "<cmd>:Gen Chat<CR>", mode = "n", "Chat with AI" },
      { "<leader>ae", "<cmd>:Gen Enhance_Code<CR>", mode = "n", "Enhance Code with AI" },
      { "<leader>ar", "<cmd>:Gen Review_Code<CR>", mode = "n", "Review Code with AI" },
      { "<leader>as", "<cmd>:Gen Summarize<CR>", mode = "n", "Summarize text with AI" },
      { "<leader>ag", "<cmd>:Gen Enhance_Grammar_Spelling<CR>", mode = "n", "Enhance grammar/spelling with AI" },

      -- Visual Mode Operations (Functions had to be seprated to retain replace/limited context operations)
      { "<leader>aa", "<cmd>:'<,'>Gen<CR>", mode = "v", desc = "Launch AI" },
      { "<leader>ac", "<cmd>:'<,'>Gen Chat<CR>", mode = "v", "Chat with AI" },
      { "<leader>ae", "<cmd>:'<,'>Gen Enhance_Code<CR>", mode = "v", "Enhance Code with AI" },
      { "<leader>ar", "<cmd>:'<,'>Gen Review_Code<CR>", mode = "v", "Review Code with AI" },
      { "<leader>as", "<cmd>:'<,'>Gen Summarize<CR>", mode = "v", "Summarize text with AI" },
      { "<leader>ag", "<cmd>:'<,'>Gen Enhance_Grammar_Spelling<CR>", mode = "v", "Enhance grammar/spelling with AI" },
    },
  },
}
