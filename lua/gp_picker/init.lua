local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local gp = require('gp')

local M = {}

---@class ExtensionOpts
---@field chat_mode? 'chat'|'command'|'both' to force a specific mode
M.extension_opts = {}

local function models(opts)
    opts = opts or {}
    local buf = vim.api.nvim_get_current_buf()
    local file_name = vim.api.nvim_buf_get_name(buf)
    local is_chat = require('gp').not_chat(buf, file_name) == nil

    local prompt_title = is_chat and 'Chat Models' or 'Completion Models'
    local results = is_chat and gp._chat_agents or gp._command_agents

    if M.extension_opts.chat_mode == 'chat' then
        prompt_title = 'Chat Models'
        results = gp._chat_agents
    end

    if M.extension_opts.chat_mode == 'command' then
        prompt_title = 'Command Models'
        results = gp._chat_agents
    end

    pickers
        .new(opts, {
            prompt_title = prompt_title,
            finder = finders.new_table({
                results = results,
            }),
            sorter = conf.generic_sorter(opts),
            previewer = require('telescope.previewers').new_buffer_previewer({
                define_preview = function(self, entry, status)
                    local agent = gp.agents[entry[1]]

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


function M.agent_picker()
    local telescope_opts = require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = true,
    })

    models(telescope_opts)
end

function M.config(opts)
    M.extension_opts = opts
end

return M
