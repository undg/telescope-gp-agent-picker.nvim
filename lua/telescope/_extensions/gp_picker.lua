local gp_picker = require('gp_picker')

return require('telescope').register_extension({
  setup = function(ext_config, config)
    gp_picker.config(ext_config)
  end,
  exports = {
    agent = gp_picker.agent_picker,
  },
})
