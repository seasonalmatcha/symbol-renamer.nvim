local ok = pcall(require, "plenary")

if not ok then
  vim.notify("This plugin requires plenary.nvim", vim.log.levels.ERROR, { title = "symbol-renamer.nvim" })
end
