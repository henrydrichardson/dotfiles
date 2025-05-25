return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas({
                replace = {
                  ["gitlab-ci"] = {
                    description = "Gitlab CI Overridden",
                    fileMatch = {
                      "**/*.gitlab-ci.yaml",
                      "**/*.gitlab-ci.yml",
                      "**/.gitlab-ci*.yaml",
                      "**/.gitlab-ci*.yml",
                      "**/.gitlab-ci.yaml",
                      "**/.gitlab-ci.yml",
                      ".gitlab-ci*.yaml",
                      ".gitlab-ci*.yml",
                    },
                    name = "gitlab-ci",
                    url = "file://" .. vim.fn.stdpath("config") .. "/schemas/custom-gitlab-ci.json",
                  },
                },
              })
            )
          end,
          settings = {
            yaml = {
              customTags = { "!reference sequence" },
              schemaStore = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
