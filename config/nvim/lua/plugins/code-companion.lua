local function get_strategy_adapter(is_reasoning)
  local adapter = ""
  if vim.env.SYSTEM_USAGE_TYPE == "personal" then
    if is_reasoning == true then
      adapter = "ollama_reasoning"
    else
      adapter = "ollama"
    end
  else
    adapter = "copilot"
  end
  return adapter
end

local function ollama_reasoning_model_default()
  return "cogito:14b"
end

return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gpt-4o",
            },
          },
        })
      end,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "gemma3:27b",
            },
            num_ctx = {
              default = 20000,
            },
          },
        })
      end,
      ollama_reasoning = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = ollama_reasoning_model_default(),
            },
            num_ctx = {
              default = 20000,
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = get_strategy_adapter(false),
      },
      inline = {
        adapter = get_strategy_adapter(false),
      },
    },
    prompt_library = {
      ["MR Crafter"] = {
        strategy = "chat",
        description = "Write merge request descriptions for me",
        opts = {
          index = 12,
          is_slash_cmd = false,
          auto_submit = true,
          short_name = "mr",
        },
        prompts = {
          {
            role = "system",
            content = [[You are a software engineer responsible for creating high-quality merge requests. This project uses Gitlab for version control. We use Gitlab Flavored Markdown for styling.]],
          },
          {
            role = "user",
            content = function()
              return string.format(
                [[Write a merge request description for the given changes below. Use @editor to apply the suggested descritpion in #buffer{watch}
```diff
%s
```
]],
                vim.fn.system("git diff --no-ext-diff origin/main")
              )
            end,
          },
        },
      },
      ["Issue Crafter"] = {
        strategy = "chat",
        description = "Write an issue descriptions for me",
        opts = {
          index = 13,
          is_slash_cmd = false,
          auto_submit = false,
          short_name = "mr",
        },
        prompts = {
          {
            role = "system",
            content = [[You are a software engineer responsible for creating high-quality issue descriptions. This project uses Gitlab for version control. We use Gitlab Flavored Markdown for styling.]],
          },
          {
            role = "user",
            content = [[Write an issue description using the following format. Also provide a title for the issue seperately in plaintext.
```
# Description


# User Statement
**As a**  
**I want to**  
**So that I can**. 

# Acceptance Criteria

- [ ] 

# Additional Notes/Documentation
```
For the following issue: ]],
          },
        },
      },
      ["Documentation Crafter"] = {
        strategy = "chat",
        description = "Write documentation for me",
        opts = {
          index = 14,
          is_slash_cmd = false,
          auto_submit = false,
          short_name = "docs",
        },
        prompts = {
          {
            role = "system",
            content = [[You are an AI documentation assistant. Your task is to generate high-quality documentation using the Diaxtras documentation framework. The output must strictly adhere to GitLab-flavored Markdown syntax. Follow these guidelines:

1. **Structure**:
   - Use the Diaxtras framework's conventions for organizing content, including sections like "Overview,"
   - Include a table of contents if the document is lengthy.

2. **Formatting**:
   - Use `#` for headings and subheadings.
   - Use fenced code blocks with the appropriate language identifier for code snippets.
   - Use bullet points, numbered lists, and tables where applicable.
   - Include links, images, and inline code formatting as needed.

3. **Clarity**:
   - Write concise, clear, and professional text.
   - Avoid unnecessary jargon and ensure the content is accessible to users of varying technical expertise.

4. **Examples**:
   - Provide practical examples and sample code where relevant.
   - Ensure examples are functional and demonstrate key features.

5. **GitLab-Specific Features**:
   - Use GitLab-flavored Markdown extensions like task lists (`- [ ]`), collapsible sections, and syntax highlighting.

6. **Output**:
   - Ensure the output is complete and ready to be used in a GitLab repository without further modification.]],
          },
          {
            role = "user",
            content = [[Write documentation for me.
The document type is a <blank>
The content should contain the following:]],
          },
        },
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
