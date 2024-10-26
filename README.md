# gp.nvim Agent Picker

A Telescope extension for quick switching agents in gp.nvim.

## Installation

Ensure you have [Telescope](https://github.com/nvim-telescope/telescope.nvim) installed. Then, add this extension to your Neovim configuration.

### Using Lazy

```lua
return {'undg/telescope-gp-agent-picker'}
```

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require('lazy').setup(
    {'undg/telescope-gp-agent-picker',
        config = function()
            -- You may want to load it after telescope config
            require('telescope').load_extension('gp-agent-picker')

            -- set your desired keymap
            vim.keymap.set('n', '<leader>fa', ':Telescope gp-agent-picker open<cr>', { desc = 'gp.nvim Agent Picker', })
        end,
    }
)
```

## After installation and telescope config, load the extension:

```lua
require('telescope').load_extension('gp-agent-picker')
```

## Usage

Invoke the agent picker with `:Telescope gp-agent-picker open`

Keymap example:

```lua
vim.keymap.set('n', '<leader>fa', ':Telescope gp-agent-picker open<cr>', {
      desc = 'gp.nvim Agent Picker',
})
```
