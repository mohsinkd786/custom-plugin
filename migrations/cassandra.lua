local plugin_config_iterator = require("kong.dao.migrations.helpers").plugin_config_iterator

return {
  {
    name = "custom_lugin",
    up =  [[
      CREATE TABLE IF NOT EXISTS custom_plugin(
        id uuid,
        consumer_id uuid,
        key text,
        created_at timestamp,
        PRIMARY KEY (id)
      );

      CREATE INDEX IF NOT EXISTS ON custom_plugin(key);
      CREATE INDEX IF NOT EXISTS custom_consumer_id ON custom_plugin(consumer_id);
    ]],
    down = [[
      DROP TABLE custom_plugin;
    ]]
  },
  {
    name = "custom_default",
    up = function(_, _, dao)
      for ok, config, update in plugin_config_iterator(dao, "custom-plugin") do
        if not ok then
          return config
        end
        if config.run_on_preflight == nil then
          config.run_on_preflight = true
          local _, err = update(config)
          if err then
            return err
          end
        end
      end
    end,
    down = function(_, _, dao) end  -- not implemented
  },
}
