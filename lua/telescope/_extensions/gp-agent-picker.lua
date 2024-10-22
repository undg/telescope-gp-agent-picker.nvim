return require('telescope').register_extension({
  setup = function(ext_config, config)
    return ext_config
  end,
  exports = {
    open = require('gp-agent-picker').open,
  },
})
