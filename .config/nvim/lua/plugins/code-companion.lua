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
