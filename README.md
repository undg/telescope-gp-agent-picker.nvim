# gp.nvim Agent Picker

A Telescope extension for quick switching agents in gp.nvim.

## Installation

Ensure you have [Telescope](https://github.com/nvim-telescope/telescope.nvim) installed. Then, add this extension to your Neovim configuration.

### Using Lazy

```lua
return {'undg/telescope-gp-agent-picker'}
```

### Using Lazy.nvim
```lua
require('undg/telescope-gp-agent-picker'}
```

### Using Plug

```lua
Plug 'undg/telescope-gp-agent-picker'
```

### Using Packer.nvim

```lua
use 'undg/telescope-gp-agent-picker'
```

```lua
require('telescope').load_extension('gp-agent-picker')
```

## Usage

Invoke the agent picker with `:Telescope gp-agent-picker`

Keymap example:

```lua
vim.keymap.set('n', '<leader>fa', ':Telescope gp-agent-picker<cr>', {
      desc = 'gp.nvim Agent Picker',
})
```
