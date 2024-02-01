local popup = require("plenary.popup")
local map = vim.keymap.set

local M = {
  opts = {
    title = "Rename Symbol",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    focusable = true,
    width = 40,
    height = 1,
    line = "cursor+2",
    col = "cursor",
    padding = { 0, 1, 0, 1 },
  },
}

function M.open()
  local curr_name = vim.fn.expand("<cword>" .. " ")
  if curr_name == "" then
    vim.notify("No selected word", vim.log.levels.ERROR, { title = "symbol-renamer.nvim" })
    return
  end

  local win_id, win = popup.create(curr_name, M.opts)

  vim.api.nvim_win_set_option(win.border.win_id, "winhl", "Normal:FloatBorder")
  vim.cmd([[
    normal A
    startinsert
  ]])

  map({ "n" }, "q", "<cmd>q<cr>", { buffer = 0 })
  map({ "n" }, "<esc>", "<cmd>q<cr>", { buffer = 0 })

  map({ "i", "n" }, "<cr>", function()
    M.apply(curr_name, win_id)
    vim.cmd("stopinsert")
  end, { buffer = 0 })
end

function M.apply(curr_name, win)
  local new_name = vim.trim(vim.fn.getline("."))
  vim.api.nvim_win_close(win, true)

  if #new_name > 0 and new_name ~= curr_name then
    local params = vim.lsp.util.make_position_params()
    params.newName = new_name

    vim.lsp.buf.rename(new_name)
  end
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

vim.api.nvim_create_user_command("SymbolRenamerOpen", function()
  M.open()
end, {})

return M
