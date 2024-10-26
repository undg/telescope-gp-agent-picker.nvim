local gp_picker = require('gp-agent-picker')

return require('telescope').register_extension({
  setup = function(ext_config, config)
    gp_picker.config(ext_config)
  end,
  exports = {
    open = gp_picker.model_picker,
  },
})
