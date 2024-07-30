-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- LazyVim.toggle.map("<leader>un", LazyVim.toggle("something", { name = "Non-Printables" }))

-- map("n", "<leader>un", "something", { desc = "Display Non-Printables" })
--
local wk = require("which-key")

wk.add({
  {
    "<leader>uv",
    icon = function()
      return vim.g.non_printable_mode == 0 and { icon = "\u{f204} ", color = "yellow" }
        or { icon = "\u{f205} ", color = "green" }
    end,
    "<cmd>:ToggleNonPrintable<CR>",
    desc = function()
      return (vim.g.non_printable_mode == 0 and "Enable" or "Disable") .. " Non-Printable"
    end,
    mode = "n",
  },
})
