return require('telescope').register_extension({
  setup = function(ext_config, config)
    require('gp-agent-picker')
  end,
})
