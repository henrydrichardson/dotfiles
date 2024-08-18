return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3.1",
    },
    cond = function()
      return vim.env.SYSTEM_USAGE_TYPE == "personal"
    end,
  },
}
