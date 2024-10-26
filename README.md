# GP Agent Picker

Telescope extension for quick agent switching in [gp.nvim](https://github.com/Robitx/gp.nvim).

![image](https://github.com/user-attachments/assets/aa4e7034-deba-4867-b134-ff46561515bb)

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'nvim-telescope/telescope.nvim',
  dependencies = {'undg/telescope-gp-agent-picker.nvim'},
  config = function()
    require('telescope').setup()
    require('telescope').load_extension('gp_picker') -- load_extension AFTER telescope.setup!!!
  end
}
```

## Use

Command: `:Telescope gp_picker agent`

Keymap:
```lua
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope gp_picker agent<cr>', {desc = 'GP Agent Picker'})
```

## Config

```lua
require('telescope').setup({
  extensions = {
    gp_picker = {
      chat_mode = 'combo' -- 'chat', 'command', or 'combo' (default)
    }
  }
})
```

`chat_mode`:
- `chat`: Use chat agents only
- `command`: Use command agents only  
- `combo`: Auto-switch based on context (default)

## Why use

- Quick agent switching
- Integrates gp.nvim with Telescope
