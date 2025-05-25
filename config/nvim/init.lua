-- TODO put this function in a better place.
local function link_lsp_log_to_temporary_file(destination)
  if vim.fn.filereadable(destination) == 0 and vim.fn.isdirectory(destination) then
    local result = vim.fn.system({ "ln", "-s", vim.lsp.get_log_path(), destination })
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to create symlink: " .. result, vim.log.levels.ERROR)
    end
  end
end

local function create_temporary_lsp_log_file()
  local log_dir = "/tmp/neovim"
  local lsp_log_file = log_dir .. "/lsp.log"

  vim.fn.mkdir(log_dir, "p")

  local file = io.open(lsp_log_file, "a")
  if file then
    file:close()
    link_lsp_log_to_temporary_file(lsp_log_file)
  else
    vim.notify("Failed to create the lsp log file: " .. lsp_log_file, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = create_temporary_lsp_log_file,
})

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
