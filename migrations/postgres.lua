local plugin_config_iterator = require("kong.dao.migrations.helpers").plugin_config_iterator

return {
  {
    name = "custom_plugin",
    up = [[
      CREATE TABLE IF NOT EXISTS custom_plugin(
        id uuid,
        consumer_id uuid REFERENCES consumers (id) ON DELETE CASCADE,
        key text UNIQUE,
        created_at timestamp without time zone default (CURRENT_TIMESTAMP(0) at time zone 'utc'),
        PRIMARY KEY (id)
      );

      DO $$
      BEGIN
        IF (SELECT to_regclass('custom_key_idx')) IS NULL THEN
          CREATE INDEX custom_key_idx ON custom_plugin(key);
        END IF;
        IF (SELECT to_regclass('custom_consumer_idx')) IS NULL THEN
          CREATE INDEX custom_consumer_idx ON custom_plugin(consumer_id);
        END IF;
      END$$;
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
