local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local gp = require('gp')

local models = function(opts)
    local buf = vim.api.nvim_get_current_buf()
    local file_name = vim.api.nvim_buf_get_name(buf)
    local is_chat = require('gp').not_chat(buf, file_name) == nil

    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = is_chat and 'Chat Models' or 'Completion Models',
            finder = finders.new_table({
                results = is_chat and gp._chat_agents or gp._command_agents,
            }),
            sorter = conf.generic_sorter(opts),
            previewer = require('telescope.previewers').new_buffer_previewer({
                define_preview = function(self, entry, status)
                    local agent = gp.agents[entry[1]]

                    P(status)

                    local lines = 'Prompt for: ' .. agent.name .. '\n'
                    lines = lines .. 'temperature: ' .. agent.model.temperature .. '; '
                    lines = lines .. 'top_p: ' .. agent.model.top_p .. '\n\n'
                    lines = lines .. agent.system_prompt


                    local content = vim.split(lines, '\n')
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, content)

                    vim.api.nvim_win_set_option(self.state.winid, 'wrap', true)
                end,
            }),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    gp.cmd.Agent({ args = selection[1] })
                end)
                return true
            end,
        })
        :find()
end

local function model_picker()
    models(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = true,
    }))
end

return { open = model_picker }
