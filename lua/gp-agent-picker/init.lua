local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local models = function(opts)
    local buf = vim.api.nvim_get_current_buf()
    local file_name = vim.api.nvim_buf_get_name(buf)
    local is_chat = require('gp').not_chat(buf, file_name) == nil

    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = is_chat and 'Models completion' or 'Models',
            finder = finders.new_table({
                results = is_chat and require('gp')._chat_agents or require('gp')._command_agents,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    require('gp').cmd.Agent({ args = selection[1] })
                end)
                return true
            end,
        })
        :find()
end

local function model_picker()
    models(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end

Keymap.normal('<leader>fa', model_picker, { desc = 'gp.nvim Agent Picker', })
