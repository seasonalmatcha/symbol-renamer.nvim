# Symbol Renamer

## Installation

```lua
-- lazy.nvim
{
  "seasonalmatcha/symbol-renamer.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}
```

## Configuration

If you don't need customization, then the setup is not necessary

Otherwise, here is an example of the setup

```lua
require("symbol-renamer").setup({
  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  relative = "cursor",
  focusable = true,
  width = 40,
  height = 1,
  line = "cursor+2",
  col = "cursor",
  padding = { 0, 1, 0, 1 },
})
```

## Usage

```lua
vim.keymap.map("n", "<leader>r", function()
  require("symbol-renamer").open()
end)
```

## Commands

- `:SymbolRenamerOpen` - Open symbol renamer dialog
