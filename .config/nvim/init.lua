-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- TODO: put this function in a better place. Mini plugin? Dedicated file to load?
vim.g.non_printable_mode = 0

function Get_color(group)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), "fg")
end

vim.g.non_printable_original_nontext = Get_color("NonText")
vim.g.non_printable_original_whitespace = Get_color("Whitespace")

vim.api.nvim_create_user_command("ToggleNonPrintable", function()
  if vim.g.non_printable_mode == 0 then
    vim.api.nvim_set_hl(0, "NonText", { fg = "#ff007c" })
    vim.api.nvim_set_hl(0, "Whitespace", { fg = "#ff007c" })
    vim.opt.listchars = {
      eol = "\u{f0311}",
      tab = "\u{21E4}-\u{21E5}", -- tab requires a string of two characters
      extends = "»",
      precedes = "«",
      trail = "\u{e3c5}",
      space = "\u{00B7}",
    }
    vim.g.non_printable_mode = 1
    vim.api.nvim_command(":IBLDisable")
  else
    vim.api.nvim_set_hl(0, "NonText", { fg = vim.g.non_printable_original_nontext })
    vim.api.nvim_set_hl(0, "Whitespace", { fg = vim.g.non_printable_original_whitespace })
    vim.cmd("set listchars&")
    vim.api.nvim_command(":IBLEnable")
    vim.g.non_printable_mode = 0
  end
end, { desc = "Enables non-printable view for diagnosing whitespace issues" })
