local generate_documentation_prompt = [[
Given the attached code file $filetype generate accurate and comprehensive documentation in $input

Please include the following information:

* **Overview**: A brief summary of what the code does, including its purpose and main functionality.
* **Functionality**: A detailed explanation of each function or method, including parameters, return values, and any notable implementation details.
* **Variables**: A description of all variables used in the code, including their scope, type, and usage.
* **Dependencies**: A list of any external libraries, frameworks, or modules required by the code.
* **Assumptions**: Any assumptions made by the code regarding input data, environmental conditions, or other factors.

Organize your documentation using clear headings and concise language. Use standard notation for explaining code snippets and syntax. If there are any complex concepts or algorithms
used in the code, please provide explanations that a novice programmer could understand.

**Code File/Snippet:**
```
$text
```
]]

return {
  {
    "David-Kunz/gen.nvim",
    cond = function()
      return vim.env.SYSTEM_USAGE_TYPE == "personal"
    end,
    init = function()
      require("gen").prompts["Generate_Documentation"] = {
        prompt = generate_documentation_prompt,
        replace = false,
      }
    end,
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
      { "<leader>aa", ":'<,'>Gen<CR>", mode = "v", desc = "Launch AI" },
      { "<leader>ac", ":'<,'>Gen Chat<CR>", mode = "v", desc = "Chat with AI" },
      { "<leader>ae", ":'<,'>Gen Enhance_Code<CR>", mode = "v", desc = "Enhance Code with AI" },
      { "<leader>ar", ":'<,'>Gen Review_Code<CR>", mode = "v", desc = "Review Code with AI" },
      { "<leader>as", ":'<,'>Gen Summarize<CR>", mode = "v", desc = "Summarize text with AI" },
      { "<leader>ag", ":'<,'>Gen Enhance_Grammar_Spelling<CR>", mode = "v", desc = "Enhance grammar/spelling with AI" },
    },
  },
}
